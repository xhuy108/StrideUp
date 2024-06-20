import 'package:equatable/equatable.dart';

class Shoes extends Equatable {
  final String name;
  final String description;
  final int energy;
  final int luck;
  final int price;
  final String image;

  const Shoes({
    required this.name,
    required this.description,
    required this.energy,
    required this.luck,
    required this.price,
    required this.image,
  });

  factory Shoes.fromJson(Map<String, dynamic> json) {
    return Shoes(
      name: json['name'],
      description: json['description'],
      energy: (json['energy'] as num).toInt(),
      luck: (json['luck'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'energy': energy,
        'luck': luck,
        'price': price,
        'image': image,
      };

  @override
  List<Object?> get props => [name, description, energy, luck, price, image];
}
