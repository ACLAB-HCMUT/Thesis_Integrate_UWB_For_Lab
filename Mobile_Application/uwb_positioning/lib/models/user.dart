class Auth {
  final String token;
  final int id;
  final String name;
  final String role;

  Auth({
    required this.token,
    required this.id,
    required this.name,
    required this.role
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['token'],
      role: json['user']['role'],
      id: json['user']['user_id'],
      name: json['user']['full_name'],
      // role: json['role'],
      // id: json['user_id'],
      // name: json['full_name'],
    );
  }
}

class User {
  final int userId;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String role;
  final String status;

  User({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'] ?? '',
      role: json['role'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'role': role,
      'status': status,
    };
  }
}