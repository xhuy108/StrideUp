import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:gap/gap.dart';
import 'package:stride_up/core/utils/show_loading_indicator.dart';
import 'package:stride_up/features/auth/bloc/auth_bloc.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';
import 'package:stride_up/features/auth/pages/log_in_page.dart';
import 'package:stride_up/features/auth/widgets/auth_input_field.dart';
import 'package:stride_up/features/auth/widgets/social_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppPalette.background,
        backgroundColor: AppPalette.background,
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
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                showLoadingIndicator(context);
              }
              if (state is AuthFailure) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is AuthSuccess) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create new account,',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppPalette.textPrimary,
                  ),
                ),
                Gap(12.h),
                Text(
                  'Enter the email address associated with your account',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppPalette.textPrimary.withOpacity(0.25),
                  ),
                ),
                Gap(28.h),
                AuthInputField(
                  hintText: 'Username',
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                ),
                Gap(20.h),
                AuthInputField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                Gap(20.h),
                AuthInputField(
                  hintText: 'Phone number',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
                Gap(20.h),
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
                Gap(20.h),
                AppButton(
                  title: 'Continue',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthSignUpWithEmailEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _nameController.text,
                            phoneNumber: _phoneController.text,
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
                    MediaResource.googleIcon,
                  ),
                  title: 'Continue with Google',
                  onPressed: () {},
                ),
                Gap(20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: AppPalette.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const LoginPage(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
