import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SeedPhraseTextItem extends StatelessWidget {
  const SeedPhraseTextItem({super.key, required this.id, required this.phrase});

  final String id;
  final String phrase;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$id. $phrase',
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: const Color(0xFF929292),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
