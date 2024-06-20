import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/features/shop/bloc/shoes_bloc.dart';
import 'package:stride_up/features/shop/widgets/search_field.dart';
import 'package:stride_up/features/shop/widgets/shoes_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ShoesBloc>().add(const FetchShoesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shop',
                  style: GoogleFonts.poppins(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Gap(10.h),
                SearchField(
                  hintText: 'Search',
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                ),
                Gap(20.h),
                Expanded(
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
