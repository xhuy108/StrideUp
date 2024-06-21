import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:stride_up/features/accountsetting/widgets/input_field.dart';

class AccountsettingPage extends StatefulWidget {
  const AccountsettingPage({Key? key});

  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountsettingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _imageFile;
  String? _username;
  String? _email;
  String? _phoneNumber;
  String? _imageUrl;

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
            _imageUrl = userData['image'];
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

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      // Create a unique file name using timestamp to avoid conflicts
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('$fileName.jpg');

      // Upload image to Firebase Storage
      await storageReference.putFile(imageFile);

      // Get URL of the uploaded image from Firebase Storage
      String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      throw e;
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
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
          String imageUrl = _imageUrl ?? '';
          if (_imageFile != null) {
            imageUrl = await _uploadImageToStorage(_imageFile!);
          }
          await _firestore.collection('users').doc(userDoc.id).update({
            'username': _usernameController.text,
            'phoneNumber': _phoneNumberController.text,
            'image': imageUrl,
          });
          await _loadUserData();
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
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : _imageUrl != null
                                  ? NetworkImage(_imageUrl!)
                                  : AssetImage('assets/images/avatar.jpg')
                                      as ImageProvider<Object>,
                          child: GestureDetector(
                            onTap: () {
                              _pickImage(); // Gọi hàm chọn ảnh khi người dùng bấm vào Avatar
                            },
                            child: _imageFile == null && _imageUrl == null
                                ? Icon(Icons
                                    .camera_alt) // Hiển thị biểu tượng camera nếu chưa có ảnh
                                : null, // Không cần child nếu đã có ảnh
                          ),
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
                        TextFormField(
                          initialValue: _email,
                          enabled: false,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppPalette.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: AppPalette.textFieldBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
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
