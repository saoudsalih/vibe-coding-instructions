/// Authenticated user from login success `data` — see models.md.
class UserModel {
  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  final int userId;
  final String name;
  final String email;
  final String role;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'role': role,
      };
}
