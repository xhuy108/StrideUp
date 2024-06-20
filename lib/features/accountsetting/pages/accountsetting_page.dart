import 'package:flutter/material.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stride_up/features/accountsetting/widgets/input_field.dart';

class AccountsettingPage extends StatelessWidget {
  const AccountsettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Setting',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppPalette.textPrimary,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Thanh Hien',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'tranthanhhien123bt@gmail.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppPalette.textSecondary,
                    ),
                  ),
                  SizedBox(height: 32),
                  InputField(
                    hintText: 'Thanh Hien',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 16),
                  InputField(
                    hintText: 'tranthanhhien123bt@gmail.com',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 16),
                  InputField(
                    hintText: '+84 398285020',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: SvgPicture.asset(MediaResource.deleteIcon),
                      label: Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.signout,
                        ),
                      ),
                      onPressed: () {
                        // Xử lý khi nhấn nút xóa tài khoản
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle update profile button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppPalette.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
