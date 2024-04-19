import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';

class ShoesInformationTag extends StatelessWidget {
  const ShoesInformationTag(
      {super.key, required this.icon, required this.value});

  final String icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppPalette.primary,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          Gap(3.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppPalette.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
