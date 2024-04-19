import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/core/common/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:stride_up/core/common/widgets/navigation_item.dart';
import 'package:stride_up/features/activity/pages/activity_page.dart';
import 'package:stride_up/features/home/pages/home_page.dart';

List<Widget> pages = [
  const HomePage(),
  const ActivityPage(),
  Container(
    color: Colors.green,
  ),
  Container(
    color: Colors.blue,
  ),
  Container(
    color: Colors.yellow,
  ),
];

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          color: AppPalette.background,
          border: Border(
            top: BorderSide(
              color: Colors.black.withOpacity(0.08),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: BlocBuilder<NavigationCubit, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavigationItem(
                  icon: MediaResource.homeIcon,
                  activeIcon: MediaResource.activeHomeIcon,
                  title: 'Home',
                  isActive: state == 0,
                  onTap: () {
                    context.read<NavigationCubit>().selectItem(0);
                  },
                ),
                NavigationItem(
                  icon: MediaResource.activityIcon,
                  activeIcon: MediaResource.activeActivityIcon,
                  title: 'Activity',
                  isActive: state == 1,
                  onTap: () {
                    context.read<NavigationCubit>().selectItem(1);
                  },
                ),
                NavigationItem(
                  icon: MediaResource.runningIcon,
                  activeIcon: MediaResource.activeRunningIcon,
                  title: 'Running',
                  isActive: state == 2,
                  onTap: () {
                    context.read<NavigationCubit>().selectItem(2);
                  },
                ),
                NavigationItem(
                  icon: MediaResource.shopIcon,
                  activeIcon: MediaResource.activeShopIcon,
                  title: 'Shop',
                  isActive: state == 3,
                  onTap: () {
                    context.read<NavigationCubit>().selectItem(3);
                  },
                ),
                NavigationItem(
                  icon: MediaResource.profileIcon,
                  activeIcon: MediaResource.profileIcon,
                  title: 'Account',
                  isActive: state == 4,
                  onTap: () {
                    context.read<NavigationCubit>().selectItem(4);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: pages[context.watch<NavigationCubit>().state],
    );
  }
}
