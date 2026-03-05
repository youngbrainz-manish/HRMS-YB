class RoleModel {
  final int? roleId;
  final String? roleName;

  RoleModel({this.roleId, this.roleName});

  RoleModel copyWith({int? roleId, String? roleName}) {
    return RoleModel(
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
    );
  }

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(roleId: json['role_id'], roleName: json['role_name']);
  }

  Map<String, dynamic> toJson() {
    return {'role_id': roleId, 'role_name': roleName};
  }
}
