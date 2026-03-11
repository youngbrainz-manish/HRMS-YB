class LeavePlanDataModel {
  final int? leavePlanId;
  final String? planName;
  final int? userCategoryId;
  final String? userCategoryName;
  final String? planStartDate;
  final String? planEndDate;
  final List<LeaveType>? leaveTypes;

  LeavePlanDataModel({
    this.leavePlanId,
    this.planName,
    this.userCategoryId,
    this.userCategoryName,
    this.planStartDate,
    this.planEndDate,
    this.leaveTypes,
  });

  factory LeavePlanDataModel.fromJson(Map<String, dynamic> json) {
    return LeavePlanDataModel(
      leavePlanId: json['leave_plan_id'],
      planName: json['plan_name'],
      userCategoryId: json['user_category_id'],
      userCategoryName: json['user_category_name'],
      planStartDate: json['plan_start_date'],
      planEndDate: json['plan_end_date'],
      leaveTypes: json['leave_types'] != null
          ? List<LeaveType>.from(
              json['leave_types'].map((x) => LeaveType.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leave_plan_id": leavePlanId,
      "plan_name": planName,
      "user_category_id": userCategoryId,
      "user_category_name": userCategoryName,
      "plan_start_date": planStartDate,
      "plan_end_date": planEndDate,
      "leave_types": leaveTypes?.map((e) => e.toJson()).toList(),
    };
  }

  LeavePlanDataModel copyWith({
    int? leavePlanId,
    String? planName,
    int? userCategoryId,
    String? userCategoryName,
    String? planStartDate,
    String? planEndDate,
    List<LeaveType>? leaveTypes,
  }) {
    return LeavePlanDataModel(
      leavePlanId: leavePlanId ?? this.leavePlanId,
      planName: planName ?? this.planName,
      userCategoryId: userCategoryId ?? this.userCategoryId,
      userCategoryName: userCategoryName ?? this.userCategoryName,
      planStartDate: planStartDate ?? this.planStartDate,
      planEndDate: planEndDate ?? this.planEndDate,
      leaveTypes: leaveTypes ?? this.leaveTypes,
    );
  }
}

class LeaveType {
  final int? leavePlanTypeId;
  final int? leavePlanId;
  final String? leaveType;
  final int? leaveCount;
  final bool? carryForward;
  final int? maxCarryForward;
  final bool? isPaid;
  final String? createdAt;
  final String? updatedAt;

  LeaveType({
    this.leavePlanTypeId,
    this.leavePlanId,
    this.leaveType,
    this.leaveCount,
    this.carryForward,
    this.maxCarryForward,
    this.isPaid,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      leavePlanTypeId: json['leave_plan_type_id'],
      leavePlanId: json['leave_plan_id'],
      leaveType: json['leave_type'],
      leaveCount: json['leave_count'],
      carryForward: json['carry_forward'],
      maxCarryForward: json['max_carry_forward'],
      isPaid: json['is_paid'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leave_plan_type_id": leavePlanTypeId,
      "leave_plan_id": leavePlanId,
      "leave_type": leaveType,
      "leave_count": leaveCount,
      "carry_forward": carryForward,
      "max_carry_forward": maxCarryForward,
      "is_paid": isPaid,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

  LeaveType copyWith({
    int? leavePlanTypeId,
    int? leavePlanId,
    String? leaveType,
    int? leaveCount,
    bool? carryForward,
    int? maxCarryForward,
    bool? isPaid,
    String? createdAt,
    String? updatedAt,
  }) {
    return LeaveType(
      leavePlanTypeId: leavePlanTypeId ?? this.leavePlanTypeId,
      leavePlanId: leavePlanId ?? this.leavePlanId,
      leaveType: leaveType ?? this.leaveType,
      leaveCount: leaveCount ?? this.leaveCount,
      carryForward: carryForward ?? this.carryForward,
      maxCarryForward: maxCarryForward ?? this.maxCarryForward,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
