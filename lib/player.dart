class Player {
  final String name;
  final int age;
  final String nationality;
  final String role;
  final String? imageUrl;

  Player({
    required this.name,
    required this.age,
    required this.nationality,
    required this.role,
    this.imageUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      age: int.parse(json['age'].toString()),
      nationality: json['nationality'],
      role: json['role'],
      imageUrl: json['image'],
    );
  }
}
