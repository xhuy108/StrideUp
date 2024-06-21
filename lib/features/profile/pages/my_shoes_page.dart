import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stride_up/features/profile/bloc/my_shoes_bloc.dart';
import 'package:stride_up/features/profile/widgets/shoes_card.dart';
import 'package:stride_up/models/shoes.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyShoesPage extends StatefulWidget {
  const MyShoesPage({Key? key}) : super(key: key);

  @override
  State<MyShoesPage> createState() => _MyShoesPageState();
}

class _MyShoesPageState extends State<MyShoesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserShoes();
  }

  void _fetchUserShoes() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String email = user.email!;
      try {
        final QuerySnapshot userSnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          final DocumentSnapshot userDoc = userSnapshot.docs.first;
          final List<dynamic> userShoeIdsDynamic = userDoc['shoes'];

          if (userShoeIdsDynamic.isNotEmpty) {
            final List<String> userShoeIds =
                List<String>.from(userShoeIdsDynamic);
            context.read<MyShoesBloc>().add(FetchShoesByIds(userShoeIds));
          } else {
            context.read<MyShoesBloc>().add(
                ShoesErrorEvent("Không tìm thấy giày nào cho người dùng này"));
          }
        } else {
          context
              .read<MyShoesBloc>()
              .add(ShoesErrorEvent("Không tìm thấy tài liệu người dùng"));
        }
      } catch (e) {
        context
            .read<MyShoesBloc>()
            .add(ShoesErrorEvent("Lỗi khi tìm kiếm tài liệu người dùng: $e"));
      }
    } else {
      context
          .read<MyShoesBloc>()
          .add(ShoesErrorEvent("Không có người dùng nào đang đăng nhập"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shoes Bag',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppPalette.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: BlocBuilder<MyShoesBloc, ShoesState>(
          builder: (context, state) {
            if (state is ShoesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppPalette.primary,
                ),
              );
            }
            if (state is ShoesFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is ShoesSuccess) {
              return GridView.builder(
                itemCount: state.shoes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) => ShoesCard(
                  shoes: state.shoes[index],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
