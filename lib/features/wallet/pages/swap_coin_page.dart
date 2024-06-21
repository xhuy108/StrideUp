import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/core/common/widgets/app_button.dart';

class SwapCoinPage extends StatefulWidget {
  const SwapCoinPage({super.key});

  @override
  State<SwapCoinPage> createState() => _SwapCoinPageState();
}

class _SwapCoinPageState extends State<SwapCoinPage> {
  final TextEditingController _fromCoinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Swap',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: const Color(0xFFF8F9F9),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'From',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF929292),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Balance: 0',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF929292),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Gap(20.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _fromCoinController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0.0',
                              hintStyle: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 162, 161, 161),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(MediaResource.bnbIcon),
                            Gap(4.w),
                            Text(
                              'BNB',
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(30.h),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFEA),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: SvgPicture.asset(MediaResource.swapIcon),
              ),
              Gap(30.h),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: const Color(0xFFF8F9F9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To (Estimate)',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF929292),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(20.h),
                    Row(
                      children: [
                        Text(
                          '0',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(MediaResource.gmtIcon),
                            Gap(4.w),
                            Text(
                              'GMT',
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(50.h),
              AppButton(
                title: 'Swap',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
