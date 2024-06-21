import 'package:stride_up/models/shoes.dart';

class User {
  final String id;
  final String name;
  final String email;

  final String image;
  final List<Shoes> shoes;
  final Shoes currentShoes;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.currentShoes,
    required this.image,
    required this.shoes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      shoes: (json['shoes'] as List).map((i) => Shoes.fromJson(i)).toList(),
      currentShoes: json['currentShoes'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'shoes': shoes,
      };
}
