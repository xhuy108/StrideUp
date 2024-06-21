import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';

import 'package:stride_up/features/home/widgets/shoes_information_tag.dart';
import 'package:stride_up/features/shop/utils/showShoesDialog.dart';
import 'package:stride_up/models/shoes.dart';

class ShoesCard extends StatelessWidget {
  const ShoesCard({super.key, required this.shoes});

  final Shoes shoes;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showShoesDialog(context, shoes);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF625C5A).withOpacity(0.1),
              blurRadius: 18,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ShoesInformationTag(
                  icon: MediaResource.luckIcon,
                  value: shoes.luck.toString(),
                ),
                const Spacer(),
                ShoesInformationTag(
                  icon: MediaResource.energyIcon,
                  value: shoes.energy.toString(),
                ),
              ],
            ),
            Gap(20.h),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Container(
                    width: 94.w,
                    height: 94.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFF75A28).withOpacity(0.06),
                          const Color(0xFFFFEAE3).withOpacity(0.47),
                        ],
                        stops: const [0, 0.57],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -4,
                  left: -4,
                  right: -4,
                  bottom: -4,
                  child: Image.network(
                    shoes.image,
                    width: 160.w,
                    height: 160.h,
                  ),
                ),
              ],
            ),
            Gap(20.h),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(MediaResource.coinIcon),
                    Gap(4.w),
                    Text(
                      shoes.price.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppPalette.primary,
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
