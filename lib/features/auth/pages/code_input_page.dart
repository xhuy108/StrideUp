import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/auth/pages/name_input_page.dart';
import 'package:stride_up/features/auth/widgets/auth_button.dart';
import 'package:stride_up/features/auth/widgets/auth_input_field.dart';
import 'package:stride_up/features/auth/widgets/skip_button.dart';

class CodeInputPage extends StatefulWidget {
  const CodeInputPage({super.key});

  @override
  State<CodeInputPage> createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SkipButton(
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter 6-digit code',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: AppPalette.textPrimary,
              ),
            ),
            Gap(12.h),
            Text(
              'We sent a verification code to your phone number +84 398 285 020',
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
              controller: _phoneController,
            ),
            Gap(15.h),
            RichText(
              text: TextSpan(
                text: 'Didn\'t receive the code? ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: 'Request again',
                    style: const TextStyle(
                      color: AppPalette.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint('Request again');
                      },
                  ),
                ],
              ),
            ),
            const Spacer(),
            AuthButton(
              title: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const NameInputPage(),
                  ),
                );
              },
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
