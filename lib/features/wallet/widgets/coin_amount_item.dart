import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';

class CoinAmountItem extends StatelessWidget {
  const CoinAmountItem(
      {super.key,
      required this.coinIcon,
      required this.coinName,
      required this.coinAmount});

  final String coinIcon;
  final String coinName;
  final String coinAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(coinIcon),
        Gap(10.w),
        Text(
          coinName,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppPalette.textPrimary,
          ),
        ),
        const Spacer(),
        Text(
          coinAmount,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppPalette.textPrimary,
          ),
        ),
      ],
    );
  }
}
