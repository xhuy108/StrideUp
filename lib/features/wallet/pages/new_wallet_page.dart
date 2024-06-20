import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';
import 'package:stride_up/features/wallet/pages/export_page.dart';
import 'package:stride_up/features/wallet/widgets/seed_phrase_text_item.dart';
import 'package:stride_up/utils/wallet_provider.dart';

class NewWalletPage extends StatefulWidget {
  NewWalletPage({super.key, required this.code});
  String code;
  @override
  State<NewWalletPage> createState() => _NewWalletPageState();
}

class _NewWalletPageState extends State<NewWalletPage> {
  List<String> phraseList = [];

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final mnemonic = walletProvider.generateMnemonic();
    setState(() {
      phraseList = mnemonic.split(' ');
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.background,
        centerTitle: true,
        title: Text(
          'New Wallet',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          '*Don’t risk losing your funds. Protect your Wallet by saving your Seed Phrase in a place you trust.',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppPalette.primary,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '\nIt’s the only way to recover your Wallet if you get locked out of the App or change to a new device.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(30.h),
                  ...List.generate(
                    phraseList.length,
                    (index) => Column(
                      children: [
                        SeedPhraseTextItem(
                          id: (index + 1).toString(),
                          phrase: phraseList[index],
                        ),
                        Gap(16.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            AppButton(
              title: 'I have written down ',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ExportPage(randomSeedPharse: phraseList, code: widget.code),
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
