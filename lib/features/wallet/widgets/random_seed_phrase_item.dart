import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';

class RandomSeedPhraseItem extends StatelessWidget {
  const RandomSeedPhraseItem({
    super.key,
    required this.phrase,
    required this.isSelected,
    this.onTap,
  });

  final String phrase;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 18.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: isSelected
                ? const Color(0xFFFFE0D6)
                : AppPalette.textFieldBackground,
          ),
          child: Text(
            phrase,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: isSelected ? AppPalette.primary : const Color(0xFF929292),
            ),
          ),
        ),
      ),
    );
  }
}
