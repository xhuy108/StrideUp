import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/activity/widgets/activity_card_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

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
                Gap(20.h),
                EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                  },
                  headerProps: const EasyHeaderProps(
                    showHeader: false,
                  ),
                  dayProps: EasyDayProps(
                    height: 90.h,
                    width: 70.w,
                    dayStructure: DayStructure.dayStrDayNum,
                    todayStyle: DayStyle(
                      splashBorder: BorderRadius.circular(100.r),
                      dayStrStyle: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF666464),
                        fontWeight: FontWeight.w500,
                      ),
                      dayNumStyle: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF666464),
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppPalette.secondary,
                          width: 2,
                        ),
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      splashBorder: BorderRadius.circular(100.r),
                      dayStrStyle: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF666464),
                        fontWeight: FontWeight.w500,
                      ),
                      dayNumStyle: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF666464),
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                    ),
                    activeDayStyle: DayStyle(
                      splashBorder: BorderRadius.circular(100.r),
                      dayStrStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      dayNumStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPalette.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppPalette.primary.withOpacity(0.3),
                            spreadRadius: 6.r,
                            blurRadius: 6.r,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(30.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ActivityCardItem(
                            backgroundColor: AppPalette.secondary,
                            isLargeCard: true,
                            icon: MediaResource.routeIcon,
                            iconBackgroundColor: AppPalette.primary,
                            value: '0.02',
                            subtitle: 'Walking + Running Distance (km)',
                            subtitleColor: Colors.white,
                            valueColor: Colors.white,
                          ),
                          Gap(12.h),
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFE3E4FF),
                            value: '4:10',
                            icon: MediaResource.averageSpeedIcon,
                            iconBackgroundColor: const Color(0xFF8769FF),
                            subtitle: 'Your average speed (min/km)',
                          ),
                          Gap(12.h),
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFFFEEE8),
                            value: '0',
                            icon: MediaResource.heartRateIcon,
                            iconBackgroundColor: const Color(0xFFFF7070),
                            subtitle: 'Your total heart rate',
                          ),
                        ],
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFFFF5E3),
                            value: '01',
                            icon: MediaResource.activeDayIcon,
                            iconBackgroundColor: const Color(0xFFFFCB44),
                            subtitle: 'Your active day of week',
                          ),
                          Gap(12.h),
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFF7F7F7),
                            isLargeCard: true,
                            value: '0.02',
                            icon: MediaResource.activeTimeIcon,
                            iconBackgroundColor: const Color(0xFF555555),
                            subtitle: 'Your active times',
                          ),
                          Gap(12.h),
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFEAFFE8),
                            value: '0',
                            icon: MediaResource.stepIcon,
                            iconBackgroundColor: const Color(0xFF82F58E),
                            subtitle: 'Your total steps (step/min)',
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
