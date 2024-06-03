import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';
import 'package:stride_up/core/common/widgets/navigation_menu.dart';
import 'package:stride_up/features/wallet/widgets/email_verification_field.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  final _phraseController = TextEditingController();
  final _emailVerificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.background,
        centerTitle: true,
        title: Text(
          'Import Wallet',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 22.sp,
            color: AppPalette.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Seed Phrase',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.textPrimary,
                ),
              ),
            ),
            Gap(20.h),
            TextFormField(
              controller: _phraseController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter the Seed Phrase word and separate with space',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF929292),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppPalette.primary),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                contentPadding: EdgeInsets.all(20.w),
                filled: true,
                fillColor: AppPalette.textFieldBackground,
              ),
            ),
            Gap(20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email verification code',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.textPrimary,
                ),
              ),
            ),
            Gap(10.h),
            EmailVerificationField(controller: _emailVerificationController),
            const Spacer(),
            AppButton(
              title: 'Import Wallet',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const NavigationMenu(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
