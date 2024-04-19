import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';

class ActivityCardItem extends StatelessWidget {
  const ActivityCardItem({
    super.key,
    required this.backgroundColor,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.iconBackgroundColor,
    this.isLargeCard = false,
    this.subtitleColor = const Color(0xFF3D3D3D),
    this.valueColor = AppPalette.textPrimary,
  });

  final Color backgroundColor;
  final String subtitle;
  final String value;
  final String icon;
  final Color iconBackgroundColor;
  final bool isLargeCard;
  final Color subtitleColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLargeCard ? 166.h : 110.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isLargeCard
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(icon),
                    ),
                    Gap(10.h),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: valueColor,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: valueColor,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 32.w,
                      height: 32.h,
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(icon),
                    ),
                  ],
                ),
          Gap(6.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
