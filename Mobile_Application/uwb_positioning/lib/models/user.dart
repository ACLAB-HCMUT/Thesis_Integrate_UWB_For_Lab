class User {
  final int id;
  final String name;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.role
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // token: json['token'],
      // role: json['user']['role'],
      // id: json['user']['user_id'],
      // name: json['user']['full_name'],
      role: json['role'],
      id: json['user_id'],
      name: json['full_name'],
    );
  }
}
