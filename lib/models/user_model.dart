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
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    this.isActive = true,
    this.createdAt,
    this.token,
  });

  /// ================= COPY WITH =================
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
    String? token,
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
      token: token ?? this.token,
    );
  }

  /// ================= FROM LOGIN API =================
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final roles = json['role'] as List?;

    return UserModel(
      id: json['emp_id'],
      name: "${json['First_Name'] ?? ''} ${json['Last_Name'] ?? ''}".trim(),
      email: json['email'] ?? '',
      phone: '', // API not providing phone
      profileImage: json['Profile_photo'],
      token: json['token'],
      role: _parseRole(roles),
      isActive: true,
      createdAt: null,
    );
  }

  /// ================= FROM MAP =================
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['emp_id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['Profile_photo'],
      token: json['token'],
      role: json['role'] == 'hr' ? UserRole.hr : UserRole.employee,
      isActive: true,
      createdAt: null,
    );
  }

  /// ================= TO JSON =================
  Map<String, dynamic> toJson() {
    return {
      'emp_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'role': role.name,
      'token': token,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// ================= ROLE PARSER =================
  static UserRole _parseRole(List? roles) {
    if (roles == null || roles.isEmpty) {
      return UserRole.employee;
    }

    final roleName = roles.first['role_name']?.toString().toLowerCase();

    switch (roleName) {
      case 'admin':
      case 'hr':
        return UserRole.hr;

      case 'employee':
      default:
        return UserRole.employee;
    }
  }

  /// ================= GETTERS =================
  bool get isHr => role == UserRole.hr;
  bool get isEmployee => role == UserRole.employee;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role)';
  }
}
