import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/running/widgets/running_information_item.dart';

void showRunningResultDialog(BuildContext context, double distance) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Activity Record',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: AppPalette.textPrimary,
              ),
            ),
            Gap(24.h),
            Text(
              distance.toString(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 28.sp,
                color: AppPalette.primary,
              ),
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RunningInformationItem(
                  value: '6’38’’',
                  title: 'Time',
                ),
                RunningInformationItem(
                  value: '6',
                  title: 'Time',
                ),
                RunningInformationItem(
                  value: '410kcal',
                  title: 'Calories',
                ),
              ],
            ),
            Gap(25.h),
            Row(
              children: [
                Text(
                  'Coin',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: const Color(0xFF929292),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(MediaResource.coinIcon),
                    Gap(4.w),
                    Text(
                      '100',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(24.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppPalette.primary,
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppPalette.background,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
