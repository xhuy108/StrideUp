import 'package:flutter/material.dart';
import 'package:stride_up/config/themes/app_palette.dart';
import 'package:stride_up/config/themes/media_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHeader extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder for loading state
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data found'); // Placeholder for no data
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        String _username = userData['username'] ?? 'Loading...';
        String _avatarUrl = userData['image'] ??
            ''; // Assuming 'avatar' is the field name in Firestore

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: _avatarUrl.isNotEmpty
                    ? NetworkImage(_avatarUrl)
                    : AssetImage('assets/images/avatar.jpg') as ImageProvider,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _username,
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
      },
    );
  }
}
