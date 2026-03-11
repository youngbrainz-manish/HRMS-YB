class LeaveModel {
  final int? userAppliedLeavesId;
  final int? userId;
  final int? leavePlanTypeId;
  final String? startDate;
  final String? endDate;
  final int? totalDays;
  final String? reason;
  final String? status;
  final int? approvedBy;
  final String? managerComment;
  final LeavePlanType? leavePlanType;

  LeaveModel({
    this.userAppliedLeavesId,
    this.userId,
    this.leavePlanTypeId,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.reason,
    this.status,
    this.approvedBy,
    this.managerComment,
    this.leavePlanType,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      userAppliedLeavesId: json['user_applied_leaves_id'],
      userId: json['user_id'],
      leavePlanTypeId: json['leave_plan_type_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalDays: json['total_days'],
      reason: json['reason'],
      status: json['status'],
      approvedBy: json['approved_by'],
      managerComment: json['manager_comment'],
      leavePlanType: json['leave_plan_type'] != null
          ? LeavePlanType.fromJson(json['leave_plan_type'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_applied_leaves_id": userAppliedLeavesId,
      "user_id": userId,
      "leave_plan_type_id": leavePlanTypeId,
      "start_date": startDate,
      "end_date": endDate,
      "total_days": totalDays,
      "reason": reason,
      "status": status,
      "approved_by": approvedBy,
      "manager_comment": managerComment,
      "leave_plan_type": leavePlanType?.toJson(),
    };
  }

  LeaveModel copyWith({
    int? userAppliedLeavesId,
    int? userId,
    int? leavePlanTypeId,
    String? startDate,
    String? endDate,
    int? totalDays,
    String? reason,
    String? status,
    int? approvedBy,
    String? managerComment,
    LeavePlanType? leavePlanType,
  }) {
    return LeaveModel(
      userAppliedLeavesId: userAppliedLeavesId ?? this.userAppliedLeavesId,
      userId: userId ?? this.userId,
      leavePlanTypeId: leavePlanTypeId ?? this.leavePlanTypeId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      approvedBy: approvedBy ?? this.approvedBy,
      managerComment: managerComment ?? this.managerComment,
      leavePlanType: leavePlanType ?? this.leavePlanType,
    );
  }
}

class LeavePlanType {
  final int? leavePlanTypeId;
  final String? leaveType;
  final int? leaveCount;

  LeavePlanType({this.leavePlanTypeId, this.leaveType, this.leaveCount});

  factory LeavePlanType.fromJson(Map<String, dynamic> json) {
    return LeavePlanType(
      leavePlanTypeId: json['leave_plan_type_id'],
      leaveType: json['leave_type'],
      leaveCount: json['leave_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leave_plan_type_id": leavePlanTypeId,
      "leave_type": leaveType,
      "leave_count": leaveCount,
    };
  }

  LeavePlanType copyWith({
    int? leavePlanTypeId,
    String? leaveType,
    int? leaveCount,
  }) {
    return LeavePlanType(
      leavePlanTypeId: leavePlanTypeId ?? this.leavePlanTypeId,
      leaveType: leaveType ?? this.leaveType,
      leaveCount: leaveCount ?? this.leaveCount,
    );
  }
}
