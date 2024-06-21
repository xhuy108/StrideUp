import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/features/shop/bloc/shoes_bloc.dart';
import 'package:stride_up/features/shop/widgets/shoes_card.dart';

class MyShoesPage extends StatefulWidget {
  const MyShoesPage({super.key});

  @override
  State<MyShoesPage> createState() => _MyShoesPageState();
}

class _MyShoesPageState extends State<MyShoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Shoes',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        child: BlocBuilder<ShoesBloc, ShoesState>(
          builder: (context, state) {
            if (state is ShoesLoading) {
              return const Center(
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
                  childAspectRatio: 0.64,
                ),
                itemBuilder: (context, index) => ShoesCard(
                  shoes: state.shoes[index],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
