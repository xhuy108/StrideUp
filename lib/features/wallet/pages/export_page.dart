import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';
import 'package:stride_up/features/wallet/pages/wallet_page.dart';
import 'package:stride_up/features/wallet/repositories/wallet_repository.dart';
import 'package:stride_up/features/wallet/widgets/email_verification_field.dart';
import 'package:stride_up/features/wallet/widgets/random_seed_phrase_item.dart';
import 'package:stride_up/utils/singleton.dart';
import 'package:stride_up/utils/wallet_provider.dart';

class ExportPage extends StatefulWidget {
  ExportPage({super.key, required this.randomSeedPharse, required this.code});
  List<String> randomSeedPharse;
  String code;
  @override
  State<ExportPage> createState() => _ExportPageState();
}

List<T> shuffleList<T>(List<T> list) {
  List<T> shuffledList = List<T>.from(list); // Tạo một bản sao của mảng gốc
  final random = Random();
  for (int i = shuffledList.length - 1; i > 0; i--) {
    final j = random.nextInt(i + 1);
    final temp = shuffledList[i];
    shuffledList[i] = shuffledList[j];
    shuffledList[j] = temp;
  }
  return shuffledList;
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
  List<String> selectedPhrases = [];

  @override
  void initState() {
    super.initState();
    // Trộn ngẫu nhiên các phần tử khi khởi tạo widget
    setState(() {
      selectedPhrases = shuffleList(widget.randomSeedPharse);
    });
  }

  bool checkKeyword() {
    String validText = "";
    for (int i = 0; i < widget.randomSeedPharse.length; i++) {
      validText = "$validText${widget.randomSeedPharse[i]} ";
    }
    String text = _phraseController.text;
    return text == validText;
  }

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
          onPressed: () async {
            if (checkKeyword()) {
              WalletRepository walletRepository = WalletRepository();
              String mnemonic = widget.randomSeedPharse.join(" ");
              WalletProvider walletProvider = WalletProvider();
              String privateKey = await walletProvider.getPrivateKey(mnemonic);
              String publicAddress =
                  (await walletProvider.getPublicKey(privateKey)).hex;
              final repsoneCode = await walletRepository.createNewWallet(
                  publicAddress, privateKey, widget.code);
              repsoneCode.fold(
                (failure) => {
                  Singleton.instanceLogger
                      .e("create-wallet ${failure.errorMessage}")
                },
                (_) => {},
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const WalletPage(),
                ),
              );
            } else {
              print("not right");
            }
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
                maxLines: 6,
                enabled: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppPalette.primary),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
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
                  ...selectedPhrases.map(
                    (phrase) => RandomSeedPhraseItem(
                      phrase: phrase,
                      isSelected: selectedPhrases.contains(phrase),
                      onTap: () {
                        setState(() {
                          if (selectedPhrases.contains(phrase)) {
                            selectedPhrases.remove(phrase);
                            _phraseController.text =
                                "${_phraseController.text}$phrase ";
                          } else {
                            selectedPhrases.add(phrase);
                          }
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
