import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
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
                'Thanh Hien',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.monetization_on, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text('134'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
