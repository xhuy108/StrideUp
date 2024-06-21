import 'package:stride_up/models/shoes.dart';

class User {
  final String id;
  final String name;
  final String email;
  final int coin;
  final String image;
  final List<String> shoes;
  final String currentShoes;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.currentShoes,
    required this.image,
    required this.shoes,
    required this.coin
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      shoes: List<String>.from(json['shoes']),
      currentShoes: json['currentShoes'],
      image: json['image'],
      coin: (json['coin'] as num).toInt()
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'shoes': shoes,
      };
}
