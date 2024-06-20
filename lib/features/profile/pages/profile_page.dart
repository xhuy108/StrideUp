import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stride_up/core/common/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:stride_up/core/utils/show_loading_indicator.dart';
import 'package:stride_up/features/accountsetting/pages/accountsetting_page.dart';
import 'package:stride_up/features/auth/bloc/auth_bloc.dart';
import 'package:stride_up/features/auth/pages/log_in_page.dart';
import 'package:stride_up/features/changepass/pages/changepass_page.dart';
import '../widgets/user_header.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is AuthLoading) {
            showLoadingIndicator(context);
          }
          if (state is AuthSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          }
        },
        child: ListView(
          children: <Widget>[
            UserHeader(),
            Gap(16.h), // Khoảng cách giữa UserHeader và danh sách
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Personal',
                style: TextStyle(
                  fontSize: 14,
                  color: AppPalette.textPrimary,
                ),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(MediaResource.pro5Icon),
              title: Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: AppPalette.primary),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountsettingPage()),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(MediaResource.shoebagIcon),
              title: Text(
                'Shoes Bag',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: AppPalette.primary),
              onTap: () {
                // Chuyển đến Giỏ giày
              },
            ),
            ListTile(
              leading: SvgPicture.asset(MediaResource.passIcon),
              title: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: AppPalette.primary),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangepassPage()),
                );
              },
            ),
            SizedBox(height: 16), // Khoảng cách giữa các phần
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'References',
                style: TextStyle(
                  fontSize: 14,
                  color: AppPalette.textPrimary,
                ),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(MediaResource.paymentIcon),
              title: Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: AppPalette.primary),
              onTap: () {
                // Chuyển đến Phương thức thanh toán
              },
            ),
            ListTile(
              leading: SvgPicture.asset(MediaResource.notiIcon),
              title: Text(
                'Notification',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: AppPalette.primary),
              onTap: () {
                // Chuyển đến Thông báo
              },
            ),
            ListTile(
              leading: SvgPicture.asset(MediaResource.customappIcon),
              title: Text(
                'Custom App Icon',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: AppPalette.primary),
              onTap: () {
                // Chuyển đến Biểu tượng ứng dụng tùy chỉnh
              },
            ),
            SizedBox(height: 16), // Khoảng cách giữa các phần
            ListTile(
              leading: SvgPicture.asset(MediaResource.signoutIcon),
              title: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.signout,
                ),
              ),
              onTap: () {
                context.read<AuthBloc>().add(const AuthLogOutEvent());
                context.read<NavigationCubit>().reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
