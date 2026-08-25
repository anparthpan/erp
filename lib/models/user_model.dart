enum UserRole { admin, staff }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  bool get isAdmin => role == UserRole.admin;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'role': role.index,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    role: UserRole.values[json['role']],
  );

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    UserRole? role,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}
