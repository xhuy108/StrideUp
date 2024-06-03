import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';

class WalletActionButton extends StatelessWidget {
  const WalletActionButton({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  final String title;
  final String icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            padding: EdgeInsets.all(10.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            backgroundColor: const Color(0xFFFFEFEA),
          ),
          icon: SvgPicture.asset(icon),
        ),
        Gap(4.h),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: AppPalette.textPrimary,
          ),
        ),
      ],
    );
  }
}
