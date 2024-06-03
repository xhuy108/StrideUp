import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/wallet/pages/create_passcode_page.dart';
import 'package:stride_up/features/wallet/pages/import_page.dart';

void showAddNewWalletPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(10.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(MediaResource.walletWarningIcon),
            Gap(16.h),
            Text(
              'BSC Wallet',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 26.sp,
                color: AppPalette.textPrimary,
              ),
            ),
            Gap(20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const CreatePasscodePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppPalette.background,
                  side: const BorderSide(color: AppPalette.primary),
                ),
                child: Text(
                  'Create a new wallet',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppPalette.primary,
                  ),
                ),
              ),
            ),
            Gap(12.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const ImportPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppPalette.primary,
              ),
              child: Text(
                'Import a wallet using Seed Phrase',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppPalette.background,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
