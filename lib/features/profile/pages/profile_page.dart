import 'package:flutter/material.dart';
import 'package:stride_up/features/accountsetting/pages/accountsetting_page.dart';
import 'package:stride_up/features/changepass/pages/changepass_page.dart';
import '../widgets/user_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          UserHeader(),
          SizedBox(height: 16), // Khoảng cách giữa UserHeader và danh sách
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Personal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.orange),
            title: Text('Account Settings'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountsettingPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text('Shoes Bag'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Chuyển đến Giỏ giày
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.orange),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.orange),
            title: Text('Payment Methods'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Chuyển đến Phương thức thanh toán
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.orange),
            title: Text('Notification'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Chuyển đến Thông báo
            },
          ),
          ListTile(
            leading: Icon(Icons.image, color: Colors.orange),
            title: Text('Custom App Icon'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Chuyển đến Biểu tượng ứng dụng tùy chỉnh
            },
          ),
          SizedBox(height: 16), // Khoảng cách giữa các phần
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Sign Out'),
            onTap: () {
              // Xử lý Đăng xuất
            },
          ),
        ],
      ),
    );
  }
}
