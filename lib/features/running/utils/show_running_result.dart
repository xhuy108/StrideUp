import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/running/widgets/running_information_item.dart';
import 'package:stride_up/models/running_record.dart';
  String convertTimeToString(int time) {
    int hour = (time / 3600).floor();
    int min = ((time - hour * 3600) / 60).floor();
    int seconds = time - hour * 3600 - min * 60;
    return '${hour}:${min}:${seconds}';
  }
    String convertRunningDistanceToString(int distance) {
    if (distance < 1000) {
      return '$distance M';
    }
    return '${(distance / 1000).toDouble()} KM';
  }

void showRunningResultDialog(BuildContext context, RunningRecord runningRecord) {
  DateTime currentTime = DateTime.now();
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
              convertRunningDistanceToString(runningRecord.distanceGo),
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
                  value: "${currentTime.day}/${currentTime.month}/${currentTime.year} ${currentTime.hour}:${currentTime.minute}",
                  title: 'Time Finish',
                ),
                RunningInformationItem(
                  value: convertTimeToString(runningRecord.time),
                  title: 'Time',
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
                      runningRecord.coin.toString(),
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
