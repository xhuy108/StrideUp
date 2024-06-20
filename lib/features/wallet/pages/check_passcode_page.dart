import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';
import 'package:stride_up/features/auth/widgets/auth_input_field.dart';
import 'package:stride_up/features/wallet/pages/new_wallet_page.dart';
import 'package:stride_up/features/wallet/pages/wallet_page.dart';
import 'package:stride_up/features/wallet/repositories/wallet_repository.dart';

class CheckPasscodePage extends StatefulWidget {
  const CheckPasscodePage({super.key});
  @override
  State<CheckPasscodePage> createState() => _CheckPasscodePageState();
}

class _CheckPasscodePageState extends State<CheckPasscodePage> {
  final TextEditingController _passcodeController = TextEditingController();
  final WalletRepository walletRepository = const WalletRepository();
  Future<bool> checkPasscode(String passcode) async{
    final respone = await walletRepository.checkWalletPasscode(passcode);
    
    bool result = respone.fold(
        (l) {
          return false;
        }, 
        (r) {
          return r;
        }
      );

    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.background,
        centerTitle: true,
        title: Text(
          'E-Wallet',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(36.h),
            Text(
              'Secured Passcode',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: AppPalette.textPrimary,
              ),
            ),
            Gap(12.h),
            Text(
              'Enter your passcode to E-Waller',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppPalette.textPrimary.withOpacity(0.25),
              ),
            ),
            Gap(28.h),
            AuthInputField(
              hintText: '------',
              keyboardType: TextInputType.number,
              textStyle: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: AppPalette.textPrimary,
                letterSpacing: 18.w,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                if (value.length == 6) {
                  FocusScope.of(context).nextFocus();
                }
              },
              controller: _passcodeController,
            ),
            const Spacer(),
            AppButton(
              title: 'Continue',
              onPressed: () async {
                if(await checkPasscode(_passcodeController.text))
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const WalletPage(),
                    ),
                  );
                }
                else{
                  Fluttertoast.showToast(
                      msg: "Passcode incorrect",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              },
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
