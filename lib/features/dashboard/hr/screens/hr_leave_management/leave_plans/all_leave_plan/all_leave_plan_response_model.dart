import 'package:hrms_yb/shared/models/user_category_model.dart';

class AllLeavePlansResponseModel {
  final bool? success;
  final String? message;
  final LeavePlansData? data;

  AllLeavePlansResponseModel({this.success, this.message, this.data});

  factory AllLeavePlansResponseModel.fromJson(Map<String, dynamic> json) {
    return AllLeavePlansResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? LeavePlansData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data?.toJson()};
  }
}

class LeavePlansData {
  final int? totalRecords;
  final int? currentPage;
  final int? totalPages;
  final List<LeavePlan>? data;

  LeavePlansData({this.totalRecords, this.currentPage, this.totalPages, this.data});

  factory LeavePlansData.fromJson(Map<String, dynamic> json) {
    return LeavePlansData(
      totalRecords: json['totalRecords'],
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      data: json['data'] != null ? List<LeavePlan>.from(json['data'].map((x) => LeavePlan.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalRecords": totalRecords,
      "currentPage": currentPage,
      "totalPages": totalPages,
      "data": data?.map((x) => x.toJson()).toList(),
    };
  }
}

class LeavePlan {
  final int? leavePlanId;
  final String? planName;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? updatedAt;
  final UserCategoryModel? userCategory;
  final List<LeaveType>? leaveTypes;

  LeavePlan({
    this.leavePlanId,
    this.planName,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.userCategory,
    this.leaveTypes,
  });

  factory LeavePlan.fromJson(Map<String, dynamic> json) {
    return LeavePlan(
      leavePlanId: json['leave_plan_id'],
      planName: json['plan_name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userCategory: json['user_category'] != null ? UserCategoryModel.fromJson(json['user_category']) : null,
      leaveTypes: json['leave_types'] != null
          ? (json['leave_types'] as List).map((e) => LeaveType.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leave_plan_id": leavePlanId,
      "plan_name": planName,
      "start_date": startDate,
      "end_date": endDate,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "user_category": userCategory?.toJson(),
      "leave_types": leaveTypes?.map((e) => e.toJson()).toList(),
    };
  }
}

class UserCategory {
  final String? categoryName;
  final int? userCategoryId;

  UserCategory({this.categoryName, this.userCategoryId});

  factory UserCategory.fromJson(Map<String, dynamic> json) {
    return UserCategory(categoryName: json['category_name'], userCategoryId: json['user_category_id']);
  }

  Map<String, dynamic> toJson() {
    return {"category_name": categoryName, "user_category_id": userCategoryId};
  }
}

class LeaveType {
  final int? leavePlanTypeId;
  final String? leaveType;
  final int? leaveCount;
  final bool? carryForward;
  final int? maxCarryForward;
  final bool? isPaid;

  LeaveType({
    this.leavePlanTypeId,
    this.leaveType,
    this.leaveCount,
    this.carryForward,
    this.maxCarryForward,
    this.isPaid,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      leavePlanTypeId: json['leave_plan_type_id'],
      leaveType: json['leave_type'],
      leaveCount: json['leave_count'],
      carryForward: json['carry_forward'],
      maxCarryForward: json['max_carry_forward'],
      isPaid: json['is_paid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leave_plan_type_id": leavePlanTypeId,
      "leave_type": leaveType,
      "leave_count": leaveCount,
      "carry_forward": carryForward,
      "max_carry_forward": maxCarryForward,
      "is_paid": isPaid,
    };
  }
}
