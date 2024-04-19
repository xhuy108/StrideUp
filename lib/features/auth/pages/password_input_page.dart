import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/auth/widgets/auth_button.dart';
import 'package:stride_up/features/auth/widgets/auth_input_field.dart';
import 'package:stride_up/features/auth/widgets/skip_button.dart';
import 'package:stride_up/features/home/pages/home_page.dart';

class PasswordInputPage extends StatefulWidget {
  const PasswordInputPage({super.key});

  @override
  State<PasswordInputPage> createState() => _PasswordInputPageState();
}

class _PasswordInputPageState extends State<PasswordInputPage> {
  bool _isObscure = true;
  final TextEditingController _passwordController = TextEditingController();

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
              'Create a password',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: AppPalette.textPrimary,
              ),
            ),
            Gap(12.h),
            Text(
              'Create a password with a least 6 letters or numbers. It should be something others can’t guess.',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppPalette.textPrimary.withOpacity(0.25),
              ),
            ),
            Gap(28.h),
            AuthInputField(
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              obscureText: _isObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: SvgPicture.asset(
                  MediaResource.showPasswordIcon,
                ),
              ),
            ),
            Gap(28.h),
            const Spacer(),
            AuthButton(
              title: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
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
