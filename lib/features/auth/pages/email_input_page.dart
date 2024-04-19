import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/features/auth/pages/phone_input_page.dart';
import 'package:stride_up/features/auth/widgets/auth_button.dart';
import 'package:stride_up/features/auth/widgets/auth_input_field.dart';
import 'package:stride_up/features/auth/widgets/social_button.dart';

class EmailInputPage extends StatefulWidget {
  const EmailInputPage({super.key});

  @override
  State<EmailInputPage> createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              MediaResource.helpIcon,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.textPrimary,
                ),
              ),
              Gap(12.h),
              Text(
                'Enter the email address associated with your Vevent account',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppPalette.textPrimary.withOpacity(0.25),
                ),
              ),
              Gap(28.h),
              AuthInputField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              Gap(20.h),
              AuthButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneInputPage(),
                    ),
                  );
                },
              ),
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppPalette.textPrimary.withOpacity(0.05),
                    ),
                  ),
                  Text(
                    "  Or  ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppPalette.textPrimary.withOpacity(0.25),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppPalette.textPrimary.withOpacity(0.05),
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              SocialButton(
                icon: SvgPicture.asset(
                  MediaResource.phoneIcon,
                ),
                title: 'Continue with Phone',
                onPressed: () {},
              ),
              Gap(15.h),
              SocialButton(
                icon: SvgPicture.asset(
                  MediaResource.googleIcon,
                ),
                title: 'Continue with Google',
                onPressed: () {},
              ),
              Gap(15.h),
              SocialButton(
                icon: SvgPicture.asset(
                  MediaResource.appleIcon,
                ),
                title: 'Continue with Apple',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
