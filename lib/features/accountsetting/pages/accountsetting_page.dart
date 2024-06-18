import 'package:flutter/material.dart';
import 'package:stride_up/features/profile/pages/profile_page.dart';

class AccountsettingPage extends StatelessWidget {
  const AccountsettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Setting'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: Padding(
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'tranthanhhien123bt@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Thanh Hien',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'tranthanhhien123bt@gmail.com',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: '+84 398285020',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            TextButton.icon(
              icon: Icon(Icons.delete, color: Colors.red),
              label: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                // Xử lý khi nhấn nút xóa tài khoản
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle change password button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Update Profile',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
