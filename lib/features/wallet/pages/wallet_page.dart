import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/core/common/widgets/navigation_menu.dart';
import 'package:stride_up/features/wallet/pages/swap_coin_page.dart';
import 'package:stride_up/features/wallet/repositories/wallet_repository.dart';
import 'package:stride_up/features/wallet/widgets/coin_amount_item.dart';
import 'package:stride_up/features/wallet/widgets/wallet_action_button.dart';
import 'package:stride_up/models/wallet.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double zCoin = 0;
  int zCoinOriginal = 0;
  double bnbCoin = 0;
  int bnbCoinOriginal = 0;
  String address = "0x";
  Stream<DocumentSnapshot<Map<String, dynamic>>> walletSnapshotStream =
      const WalletRepository().getWalletSnapshot();
  @override
  void initState() {
    super.initState();
    walletSnapshotStream.listen((event) {
      if (event.exists) {
        Wallet wallet = Wallet.fromJson(event.data()!);
        if (zCoinOriginal != wallet.zCoin) {
          zCoinOriginal = wallet.zCoin;
          setState(() {
            zCoin = getConvertCoin(wallet.zCoin);
          });
        }
        if (bnbCoinOriginal != wallet.bnbCoin) {
          bnbCoinOriginal = wallet.bnbCoin;
          setState(() {
            bnbCoin = getConvertCoin(wallet.bnbCoin);
          });
        }
        if (address != wallet.publicAddress) {
          setState(() {
            address = wallet.publicAddress;
          });
        }
      }
    });
  }
  double getConvertCoin(int input) {
      String resultString = input.toStringAsFixed(10);
      return double.parse(resultString);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'E-Wallet',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationMenu(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(24.h),
              Stack(
                children: [
                  Image.asset(MediaResource.walletBackground),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'BNB Smart Chain',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            '$bnbCoin BNB',
                            style: GoogleFonts.poppins(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w500,
                              color: AppPalette.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 216, 216, 1),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  address,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Gap(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WalletActionButton(
                    title: 'Receive',
                    icon: MediaResource.receiveIcon,
                    onPressed: () {},
                  ),
                  WalletActionButton(
                    title: 'Swap',
                    icon: MediaResource.swapIcon,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const SwapCoinPage(),
                        ),
                      );
                    },
                  ),
                  WalletActionButton(
                    title: 'Transfer',
                    icon: MediaResource.transferIcon,
                    onPressed: () {},
                  ),
                ],
              ),
              Gap(30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wallet Account',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppPalette.textPrimary,
                  ),
                ),
              ),
              Gap(20.h),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppPalette.background,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppPalette.stroke.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CoinAmountItem(
                      coinIcon: MediaResource.bnbIcon,
                      coinName: 'BNB',
                      coinAmount: '$bnbCoin',
                    ),
                    Gap(24.h),
                    CoinAmountItem(
                      coinIcon: MediaResource.gmtIcon,
                      coinName: 'ZCoin',
                      coinAmount: '$zCoin',
                    ),
                    Gap(24.h),
                    CoinAmountItem(
                      coinIcon: MediaResource.usdtIcon,
                      coinName: 'USDT',
                      coinAmount: '0',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
