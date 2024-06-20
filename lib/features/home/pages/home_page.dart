import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stride_up/background_service/background_server_notifaction.dart';
import 'package:stride_up/background_service/constant_service.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/home/widgets/award_item.dart';
import 'package:stride_up/features/home/widgets/shoes_information_tag.dart';
import 'package:stride_up/features/wallet/pages/check_passcode_page.dart';
import 'package:stride_up/features/wallet/pages/wallet_page.dart';
import 'package:stride_up/features/wallet/repositories/wallet_repository.dart';
import 'package:stride_up/features/wallet/utils/showAddWalletPopUp.dart';
import 'package:stride_up/utils/permission_service.dart';
import 'package:stride_up/utils/singleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initalizeRequestPermission();
  }
  WalletRepository walletRepository = const WalletRepository();
  Future<void> initalizeRequestPermission() async {
    await PermissionService.requestLocationPermission();
    await PermissionService.requestNotificationPermission();
    await PermissionService.requestPedometerPermission();
  }

  Future<void> initNotification() async {
    Map<String, dynamic> data = {
      'context': context,
    };

    FlutterBackgroundService()
        .invoke(ServiceMethod.START_NOTIFICATION_SERVICE, data);
  }

  @override
  Widget build(BuildContext context) {
    bool isWalletExisted = false;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 12.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    Gap(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Be Chip',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                        Gap(3.h),
                        Row(
                          children: [
                            SvgPicture.asset(MediaResource.coinIcon),
                            Gap(3.w),
                            Text(
                              '134',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppPalette.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: ()async {
                            final respone = await walletRepository.checkWallet();
                            respone.fold((exception) => Singleton.instanceLogger.e("homeError: $exception"),
                             (isWalletExisted) {
                              if (isWalletExisted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CheckPasscodePage(),
                                ),
                              );
                            } else {
                              showAddNewWalletPopUp(context);
                            }
                            });
                          },
                          icon: SvgPicture.asset(
                            MediaResource.walletIcon,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          icon: SvgPicture.asset(
                            MediaResource.settingIcon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(28.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'You have walked\n',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                      color: AppPalette.textPrimary,
                    ),
                    children: const [
                      TextSpan(
                        text: '38 km ',
                        style: TextStyle(
                          color: AppPalette.primary,
                        ),
                      ),
                      TextSpan(
                        text: 'today',
                      ),
                    ],
                  ),
                ),
                Gap(30.h),
                Stack(
                  children: [
                    Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        image: const DecorationImage(
                          image: AssetImage(MediaResource.shoesBackground),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          opacity: 0.6,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20.h,
                      left: 16.w,
                      right: 16.w,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShoesInformationTag(
                            icon: MediaResource.luckIcon,
                            value: '110',
                          ),
                          ShoesInformationTag(
                            icon: MediaResource.energyIcon,
                            value: '120',
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      left: 16.w,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: AppPalette.background,
                          ),
                          iconSize: 18.w,
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppPalette.primary,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      right: 16.w,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: AppPalette.background,
                          ),
                          iconSize: 18.w,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppPalette.primary,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/shoes.png',
                          width: 160.w,
                          height: 160.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(30.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daily awards',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppPalette.textPrimary,
                    ),
                  ),
                ),
                Gap(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => AwardItem(
                      isUnlocked: index == 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
