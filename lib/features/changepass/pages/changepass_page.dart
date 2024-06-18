import 'package:flutter/material.dart';
import 'package:stride_up/features/profile/pages/profile_page.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stride_up/features/changepass/widgets/input_field.dart';

class ChangepassPage extends StatelessWidget {
  const ChangepassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppPalette.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputField(
              hintText: 'Old Password',
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 16),
            InputField(
              hintText: 'New Password',
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 16),
            InputField(
              hintText: 'Confirm Password',
              keyboardType: TextInputType.visiblePassword,
            ),
            Spacer(),
            SizedBox(
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
                  'Change Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppPalette.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
