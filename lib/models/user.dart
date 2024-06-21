import 'package:firebase_auth/firebase_auth.dart';
import 'package:stride_up/models/shoes.dart';

class User {
  final String id;
  final String username;
  final String email;
  final int coin;
  final String image;
  final List<String> shoes;
  final String currentShoes;
  final String phoneNumber;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.currentShoes,
    required this.image,
    required this.shoes,
    required this.coin,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: FirebaseAuth.instance.currentUser!.uid,
      username: json['username'],
      email: json['email'],
      shoes: List<String>.from(json['shoes']),
      currentShoes: json['currentShoes'],
      image: json['image'],
      coin: json['coin'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'shoes': shoes,
      };
}
