class HierarchyModel {
  final int empId;
  final String name;
  final String roleName;
  final String designation;
  final String profilePhoto;
  final List<HierarchyModel> children;

  HierarchyModel({
    required this.empId,
    required this.name,
    required this.roleName,
    required this.designation,
    required this.profilePhoto,
    required this.children,
  });

  factory HierarchyModel.fromJson(Map<String, dynamic> json) {
    return HierarchyModel(
      empId: json["user_id"],
      name: json["name"] ?? "",
      roleName: json["role_name"] ?? "",
      designation: json["designation"] ?? "",
      profilePhoto: json["profile_photo"] ?? "",
      children: (json["children"] as List? ?? []).map((e) => HierarchyModel.fromJson(e)).toList(),
    );
  }
}
