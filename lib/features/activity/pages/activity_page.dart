import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/activity/widgets/card_item.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 12.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(MediaResource.calendarIcon),
                    Gap(8.w),
                    Text(
                      'April',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppPalette.primary,
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                Text(
                  'Activity',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: AppPalette.textPrimary,
                  ),
                ),
                Gap(30.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CardItem(
                            height: 166.h,
                            backgroundColor: AppPalette.secondary,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: AppPalette.primary,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child:
                                      SvgPicture.asset(MediaResource.routeIcon),
                                ),
                                Gap(10.h),
                                Text(
                                  '0.02',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppPalette.background,
                                  ),
                                ),
                                Gap(4.h),
                                Text(
                                  'Walking + Running Distance (km)',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppPalette.background,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(12.h),
                          CardItem(
                            height: 110.h,
                            backgroundColor: const Color(0xFFE3E4FF),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '4:10',
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppPalette.textPrimary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 32.w,
                                      height: 32.h,
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8769FF),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: SvgPicture.asset(
                                          MediaResource.averageSpeedIcon),
                                    ),
                                  ],
                                ),
                                Gap(6.h),
                                Text(
                                  'Your average speed (min/km)',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3D3D3D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(12.h),
                          CardItem(
                            height: 110.h,
                            backgroundColor: const Color(0xFFFFEEE8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppPalette.textPrimary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 32.w,
                                      height: 32.h,
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF7070),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: SvgPicture.asset(
                                        MediaResource.heartRateIcon,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(6.h),
                                Text(
                                  'Your total heart rate',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3D3D3D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CardItem(
                            height: 110.h,
                            backgroundColor: const Color(0xFFFFF5E3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '01',
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppPalette.textPrimary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 32.w,
                                      height: 32.h,
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFCB44),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: SvgPicture.asset(
                                        MediaResource.activeDayIcon,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(6.h),
                                Text(
                                  'Your active day of month',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3D3D3D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(12.h),
                          CardItem(
                            height: 166.h,
                            backgroundColor: const Color(0xFFF7F7F7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF555555),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: SvgPicture.asset(
                                    MediaResource.activeTimeIcon,
                                  ),
                                ),
                                Gap(10.h),
                                Text(
                                  '0.02',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3D3D3D),
                                  ),
                                ),
                                Gap(4.h),
                                Text(
                                  'Your active times',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3D3D3D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(12.h),
                          CardItem(
                            height: 110.h,
                            backgroundColor: const Color(0xFFEAFFE8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppPalette.textPrimary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 32.w,
                                      height: 32.h,
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF82F58E),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: SvgPicture.asset(
                                        MediaResource.activeDayIcon,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(6.h),
                                Text(
                                  'Your total steps (step/min)',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3D3D3D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
