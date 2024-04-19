import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';

class AwardItem extends StatelessWidget {
  const AwardItem({super.key, this.isUnlocked = false});

  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: isUnlocked ? AppPalette.primary : const Color(0xFFEBEBEB),
      ),
      child: Column(
        children: [
          Image.asset(
            MediaResource.giftBox,
            width: 70.w,
            height: 70.h,
          ),
          Gap(5.h),
          Text(
            'ZRace\nunlocked',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isUnlocked
                  ? Colors.white
                  : AppPalette.textPrimary.withOpacity(0.4),
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(9.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color:
                  isUnlocked ? AppPalette.background : const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(MediaResource.coinIcon),
                Gap(4.w),
                Text(
                  '10,000',
                  style: TextStyle(
                    color: isUnlocked
                        ? AppPalette.textPrimary
                        : const Color(0xFFCCCCCC),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
