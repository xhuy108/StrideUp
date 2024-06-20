import 'package:flutter/material.dart';
import 'package:stride_up/features/profile/pages/profile_page.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stride_up/features/changepass/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangepassPage extends StatefulWidget {
  const ChangepassPage({super.key});

  @override
  _ChangepassPageState createState() => _ChangepassPageState();
}

class _ChangepassPageState extends State<ChangepassPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _showCurrentUserEmail() async {
    if (_user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email của người dùng: ${_user!.email}')),
      );
    }
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Tạo thông tin xác thực với email và mật khẩu cũ của người dùng
        String email = _user!.email!;
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: _oldPasswordController.text,
        );

        // Xác thực lại người dùng với thông tin xác thực
        await _user!.reauthenticateWithCredential(credential);

        // Nếu xác thực lại thành công, cập nhật mật khẩu mới
        await _user!.updatePassword(_newPasswordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password has been changed')),
        );
      } catch (e) {
        String errorMessage = 'Đã xảy ra lỗi: $e';

        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'too-many-requests':
              errorMessage =
                  'Thiết bị của bạn đã bị chặn do hoạt động bất thường. Hãy thử lại sau.';
              break;
            case 'wrong-password':
              errorMessage = 'Mật khẩu cũ không đúng. Vui lòng kiểm tra lại.';
              break;
            case 'user-mismatch':
              errorMessage =
                  'Thông tin người dùng không khớp. Vui lòng thử lại.';
              break;
            case 'user-not-found':
              errorMessage =
                  'Không tìm thấy người dùng. Vui lòng kiểm tra lại.';
              break;
            case 'invalid-credential':
              errorMessage =
                  'Thông tin xác thực không hợp lệ. Vui lòng thử lại.';
              break;
            default:
              errorMessage = 'Đã xảy ra lỗi: ${e.message}';
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InputField(
                controller: _oldPasswordController,
                hintText: 'Old Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter old password';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(Icons.email),
                  onPressed: _showCurrentUserEmail,
                ),
              ),
              SizedBox(height: 16),
              InputField(
                controller: _newPasswordController,
                hintText: 'New Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  if (value.length < 6) {
                    return 'New password must have at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InputField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Confirmation password does not match';
                  }
                  return null;
                },
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _changePassword,
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
      ),
    );
  }
}
