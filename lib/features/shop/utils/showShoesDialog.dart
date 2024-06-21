import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/home/widgets/shoes_information_tag.dart';
import 'package:stride_up/features/wallet/pages/create_passcode_page.dart';
import 'package:stride_up/features/wallet/pages/import_page.dart';
import 'package:stride_up/models/shoes.dart';

void showShoesDialog(BuildContext context, Shoes shoes) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // insetPadding: EdgeInsets.all(6.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Buy',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(16.h),
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
            Text(
              shoes.name,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Gap(20.h),
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
            Gap(12.h),
            Row(
              children: [
                Text(
                  'Cost',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF929292),
                  ),
                ),
                const Spacer(),
                Text(
                  '${shoes.price.toString()} GMT',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Gap(28.h),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppPalette.primary,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 12.sp,
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
      );
    },
  );
}
