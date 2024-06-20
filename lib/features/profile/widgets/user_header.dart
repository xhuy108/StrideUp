import 'package:flutter/material.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHeader extends StatefulWidget {
  @override
  _UserHeaderState createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _username;

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
          });
        }
      }
    } catch (e) {
      print("Error retrieving user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _username ?? 'Loading...',
                style: TextStyle(
                  fontSize: 12,
                  color: AppPalette.textPrimary,
                ),
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(MediaResource.coinIcon),
                  SizedBox(width: 4),
                  Text(
                    '134',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppPalette.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
