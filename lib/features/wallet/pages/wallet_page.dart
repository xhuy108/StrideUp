import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/wallet/widgets/coin_amount_item.dart';
import 'package:stride_up/features/wallet/widgets/wallet_action_button.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'E-Wallet',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
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
                            '0 BNB',
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
                    onPressed: () {},
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
                      coinAmount: '0',
                    ),
                    Gap(24.h),
                    CoinAmountItem(
                      coinIcon: MediaResource.gmtIcon,
                      coinName: 'GMT',
                      coinAmount: '0',
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
