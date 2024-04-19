import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/auth/pages/password_input_page.dart';
import 'package:stride_up/features/auth/widgets/auth_button.dart';
import 'package:stride_up/features/auth/widgets/auth_input_field.dart';
import 'package:stride_up/features/auth/widgets/skip_button.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

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
              'What\'s your name?',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: AppPalette.textPrimary,
              ),
            ),
            Gap(12.h),
            Text(
              'What do people call you? Enter your name to get started',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppPalette.textPrimary.withOpacity(0.25),
              ),
            ),
            Gap(28.h),
            AuthInputField(
              hintText: 'First name',
              keyboardType: TextInputType.name,
              controller: _firstNameController,
            ),
            Gap(15.h),
            AuthInputField(
              hintText: 'Last name',
              keyboardType: TextInputType.name,
              controller: _lastNameController,
            ),
            const Spacer(),
            AuthButton(
              title: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordInputPage(),
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
