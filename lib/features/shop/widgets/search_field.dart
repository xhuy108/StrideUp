import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.textStyle,
    this.inputFormatters,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;

  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: textStyle,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFB5B5B5),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(16.w),
          child: SvgPicture.asset(
            MediaResource.searchIcon,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFC1C1C1).withOpacity(0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            color: AppPalette.primary,
            width: 1.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 14.h,
        ),
      ),
    );
  }
}
