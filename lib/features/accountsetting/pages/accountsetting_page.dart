import 'package:flutter/material.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stride_up/features/accountsetting/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountsettingPage extends StatefulWidget {
  const AccountsettingPage({super.key});

  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountsettingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _username;
  String? _email;
  String? _phoneNumber;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String currentUserEmail = currentUser.email!;
        QuerySnapshot userSnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: currentUserEmail)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          var userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
          setState(() {
            _username = userData['username'];
            _email = userData['email'];
            _phoneNumber = userData['phoneNumber'];
            _usernameController.text = _username ?? '';
            _emailController.text = _email ?? '';
            _phoneNumberController.text = _phoneNumber ?? '';
          });
        }
      }
    } catch (e) {
      print("Error retrieving user data: $e");
    }
  }

  Future<void> _updateUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String currentUserEmail = currentUser.email!;
        QuerySnapshot userSnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: currentUserEmail)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          var userDoc = userSnapshot.docs.first;
          await _firestore.collection('users').doc(userDoc.id).update({
            'username': _usernameController.text,
            'phoneNumber': _phoneNumberController.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Profile updated successfully!'),
          ));
        }
      }
    } catch (e) {
      print("Error updating user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update profile.'),
      ));
    }
  }

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
      body: _email == null
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                          backgroundImage:
                              AssetImage('assets/images/avatar.jpg'),
                        ),
                        SizedBox(height: 16),
                        Text(
                          _username ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _email ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppPalette.textSecondary,
                          ),
                        ),
                        SizedBox(height: 32),
                        InputField(
                          hintText: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),
                        InputField(
                          hintText: 'Username',
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 16),
                        InputField(
                          hintText: 'Phone Number',
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
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
                              // Handle account deletion
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
                      onPressed: _updateUserData,
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
