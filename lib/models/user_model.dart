import '../core/enums/user_role.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final UserRole role;
  final bool isActive;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    this.profileImage,
    this.isActive = true,
    this.createdAt,
  });

  /// CopyWith
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert JSON to Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      profileImage: json['profile_image'],
      role: _parseRole(json['role']),
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }

  /// Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'role': role.name,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// Role parser
  static UserRole _parseRole(String? role) {
    switch (role) {
      case 'hr':
        return UserRole.hr;
      case 'employee':
        return UserRole.employee;
      default:
        return UserRole.employee;
    }
  }

  /// Convenience getters
  bool get isHr => role == UserRole.hr;
  bool get isEmployee => role == UserRole.employee;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role)';
  }
}
