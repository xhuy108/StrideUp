import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/activity/repositories/activity_repository.dart';
import 'package:stride_up/features/activity/widgets/activity_card_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:stride_up/models/activity.dart';
import 'package:stride_up/utils/singleton.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  Activity activity = Activity(
      userId: auth.currentUser!.uid,
      totalDistance: 0,
      avgSpeed: 0,
      activeTime: 0,
      activeDateOfWeek: 0);
  ActivityRepository activityRepository = ActivityRepository();
  String time = "0:0:0";
  @override
  void initState() {
    super.initState();
    getActivity(DateTime.now());
  }

  Future<void> getActivity(DateTime dateTime) async {
    final response = await activityRepository.getRecordByDate(dateTime);
    setState(() {
      response.fold((l) {
        Singleton.instanceLogger.e("error $l");
        Fluttertoast.showToast(
            msg: "Load activity failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }, (r) {
        activity = r;
      });
    });
  }

  String formatActiveTime(double seconds) {
    double hours = seconds / 3600;
    double minutes = seconds / 60;

    if (hours >= 1) {
      // Nếu thời gian nhiều hơn 1 giờ, hiển thị dưới dạng giờ
      return '${hours.toStringAsFixed(1)} hours';
    } else {
      // Nếu thời gian ít hơn 1 giờ, hiển thị dưới dạng phút
      return '${minutes.toStringAsFixed(1)} mins';
    }
  }

  String convertSecondsToString(double seconds) {
    int totalSeconds = seconds.toInt();
    int minutes = totalSeconds ~/ 60;
    int remainingSeconds = totalSeconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

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
                      'June',
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
                  onDateChange: (selectedDate) async {
                    await getActivity(selectedDate);
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
                            value: '${activity!.totalDistance / 1000}',
                            subtitle: 'Walking + Running Distance (km)',
                            subtitleColor: Colors.white,
                            valueColor: Colors.white,
                          ),
                          Gap(12.h),
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFE3E4FF),
                            value: convertSecondsToString(activity.avgSpeed),
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
                            value: '${activity.activeDateOfWeek}',
                            icon: MediaResource.activeDayIcon,
                            iconBackgroundColor: const Color(0xFFFFCB44),
                            subtitle: 'Your active day of week',
                          ),
                          Gap(12.h),
                          ActivityCardItem(
                            backgroundColor: const Color(0xFFF7F7F7),
                            isLargeCard: true,
                            value: '${formatActiveTime(activity.activeTime)}',
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
