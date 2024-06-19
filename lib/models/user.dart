class User {
  final String id;
  final String name;
  final String email;
  final List<String>? shoes;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.shoes,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      shoes:
          json['shoes'] != null ? List<String>.from(json['shoes']) : <String>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'shoes': shoes,
      };
}
