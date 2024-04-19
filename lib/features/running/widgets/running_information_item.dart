import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';

class RunningInformationItem extends StatelessWidget {
  const RunningInformationItem(
      {super.key, required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppPalette.primary,
          ),
        ),
        Gap(6.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppPalette.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
