class TeamLeaveDataModel {
  final int? userAppliedLeavesId;
  final int? userId;
  final String? startDate;
  final String? endDate;
  final int? totalDays;
  final String? reason;
  final int? approvedBy;
  final String? managerComment;
  final int? leavePlanTypeId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final LeavePlanType? leavePlanType;
  final Employee? employee;

  TeamLeaveDataModel({
    this.userAppliedLeavesId,
    this.userId,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.reason,
    this.approvedBy,
    this.managerComment,
    this.leavePlanTypeId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.leavePlanType,
    this.employee,
  });

  TeamLeaveDataModel copyWith({
    int? userAppliedLeavesId,
    int? userId,
    String? startDate,
    String? endDate,
    int? totalDays,
    String? reason,
    int? approvedBy,
    String? managerComment,
    int? leavePlanTypeId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    LeavePlanType? leavePlanType,
    Employee? employee,
  }) {
    return TeamLeaveDataModel(
      userAppliedLeavesId: userAppliedLeavesId ?? this.userAppliedLeavesId,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      reason: reason ?? this.reason,
      approvedBy: approvedBy ?? this.approvedBy,
      managerComment: managerComment ?? this.managerComment,
      leavePlanTypeId: leavePlanTypeId ?? this.leavePlanTypeId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      leavePlanType: leavePlanType ?? this.leavePlanType,
      employee: employee ?? this.employee,
    );
  }

  factory TeamLeaveDataModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaveDataModel(
      userAppliedLeavesId: json["user_applied_leaves_id"],
      userId: json["user_id"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      totalDays: json["total_days"],
      reason: json["reason"],
      approvedBy: json["approved_by"],
      managerComment: json["manager_comment"],
      leavePlanTypeId: json["leave_plan_type_id"],
      status: json["status"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      leavePlanType: json["leave_plan_type"] == null
          ? null
          : LeavePlanType.fromJson(json["leave_plan_type"]),
      employee: json["employee"] == null
          ? null
          : Employee.fromJson(json["employee"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "user_applied_leaves_id": userAppliedLeavesId,
    "user_id": userId,
    "start_date": startDate,
    "end_date": endDate,
    "total_days": totalDays,
    "reason": reason,
    "approved_by": approvedBy,
    "manager_comment": managerComment,
    "leave_plan_type_id": leavePlanTypeId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "leave_plan_type": leavePlanType?.toJson(),
    "employee": employee?.toJson(),
  };
}

class LeavePlanType {
  final int? leavePlanTypeId;
  final String? leaveType;
  final int? leaveCount;
  final bool? isPaid;

  LeavePlanType({
    this.leavePlanTypeId,
    this.leaveType,
    this.leaveCount,
    this.isPaid,
  });

  LeavePlanType copyWith({
    int? leavePlanTypeId,
    String? leaveType,
    int? leaveCount,
    bool? isPaid,
  }) {
    return LeavePlanType(
      leavePlanTypeId: leavePlanTypeId ?? this.leavePlanTypeId,
      leaveType: leaveType ?? this.leaveType,
      leaveCount: leaveCount ?? this.leaveCount,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  factory LeavePlanType.fromJson(Map<String, dynamic> json) {
    return LeavePlanType(
      leavePlanTypeId: json["leave_plan_type_id"],
      leaveType: json["leave_type"],
      leaveCount: json["leave_count"],
      isPaid: json["is_paid"],
    );
  }

  Map<String, dynamic> toJson() => {
    "leave_plan_type_id": leavePlanTypeId,
    "leave_type": leaveType,
    "leave_count": leaveCount,
    "is_paid": isPaid,
  };
}

class Employee {
  final String? firstName;
  final String? lastName;
  final String? email;

  Employee({this.firstName, this.lastName, this.email});

  Employee copyWith({String? firstName, String? lastName, String? email}) {
    return Employee(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
  };
}
