class UserCategoryModel {
  final int? userCategoryId;
  final String? categoryName;
  final String? createdAt;
  final String? updatedAt;

  UserCategoryModel({this.userCategoryId, this.categoryName, this.createdAt, this.updatedAt});

  factory UserCategoryModel.fromJson(Map<String, dynamic> json) {
    return UserCategoryModel(
      userCategoryId: json['user_category_id'],
      categoryName: json['category_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_category_id": userCategoryId,
      "category_name": categoryName,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

  UserCategoryModel copyWith({int? userCategoryId, String? categoryName, String? createdAt, String? updatedAt}) {
    return UserCategoryModel(
      userCategoryId: userCategoryId ?? this.userCategoryId,
      categoryName: categoryName ?? this.categoryName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
