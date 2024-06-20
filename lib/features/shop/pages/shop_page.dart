import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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
                SearchField(
                  hintText: 'Search',
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                ),
                Gap(20.h),
                Expanded(
                  child: GridView.builder(
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (context, index) => const ShoesCard(),
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
