import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';
import 'package:stride_up/core/common/widgets/navigation_menu.dart';
import 'package:stride_up/features/wallet/pages/wallet_page.dart';
import 'package:stride_up/features/wallet/widgets/email_verification_field.dart';
import 'package:stride_up/features/wallet/widgets/random_seed_phrase_item.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  final _phraseController = TextEditingController();
  final _emailVerificationController = TextEditingController();
  final randomPhrases = [
    'Now',
    'Vast',
    'Speak',
    'Never',
    'Erode',
    'Awful',
    'Online',
    'Matter',
    'Coconut'
  ];
  final selectedPhrases = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.background,
        centerTitle: true,
        title: Text(
          'Export',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 22.sp,
            color: AppPalette.textPrimary,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(24.w),
        child: AppButton(
          title: 'Confirm',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const NavigationMenu(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '*Please choose Seed Phrase in order and make sure your Seed Phrase was correct written, once forgotten, it cannot be recovered',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppPalette.primary,
                ),
              ),
              Gap(20.h),
              TextFormField(
                controller: _phraseController,
                maxLines: 5,
                decoration: InputDecoration(
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
              Gap(16.h),
              Wrap(
                runSpacing: 10.w,
                children: [
                  ...randomPhrases.map(
                    (phrase) => RandomSeedPhraseItem(
                      phrase: phrase,
                      isSelected: selectedPhrases.contains(phrase),
                      onTap: () {
                        setState(() {
                          if (selectedPhrases.contains(phrase)) {
                            selectedPhrases.remove(phrase);
                          } else {
                            selectedPhrases.add(phrase);
                          }
                          _phraseController.text = selectedPhrases.join(" ");
                        });
                      },
                    ),
                  ),
                ],
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
              EmailVerificationField(
                controller: _emailVerificationController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
