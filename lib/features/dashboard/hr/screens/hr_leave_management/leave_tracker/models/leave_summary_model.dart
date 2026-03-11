import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/tab_widget/my_leave_requests_tab/my_leave_model.dart';

class LeaveSummaryModel {
  final bool? success;
  final String? message;
  final LeaveSummaryData? data;

  LeaveSummaryModel({this.success, this.message, this.data});

  LeaveSummaryModel copyWith({bool? success, String? message, LeaveSummaryData? data}) {
    return LeaveSummaryModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory LeaveSummaryModel.fromJson(Map<String, dynamic> json) {
    return LeaveSummaryModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null ? LeaveSummaryData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data?.toJson()};
  }
}

class LeaveSummaryData {
  final List<LeaveBalance>? leaveBalance;
  final List<UpcomingAndPastLeaveModel>? pastLeaves;
  final List<UpcomingAndPastLeaveModel>? upcomingLeaves;

  LeaveSummaryData({this.leaveBalance, this.pastLeaves, this.upcomingLeaves});

  LeaveSummaryData copyWith({
    List<LeaveBalance>? leaveBalance,
    List<UpcomingAndPastLeaveModel>? pastLeaves,
    List<UpcomingAndPastLeaveModel>? upcomingLeaves,
  }) {
    return LeaveSummaryData(
      leaveBalance: leaveBalance ?? this.leaveBalance,
      pastLeaves: pastLeaves ?? this.pastLeaves,
      upcomingLeaves: upcomingLeaves ?? this.upcomingLeaves,
    );
  }

  factory LeaveSummaryData.fromJson(Map<String, dynamic> json) {
    return LeaveSummaryData(
      leaveBalance: json["leaveBalance"] == null
          ? []
          : List<LeaveBalance>.from(json["leaveBalance"].map((x) => LeaveBalance.fromJson(x))),
      pastLeaves: json["pastLeaves"] == null
          ? []
          : List<UpcomingAndPastLeaveModel>.from(json["pastLeaves"].map((x) => UpcomingAndPastLeaveModel.fromJson(x))),
      upcomingLeaves: json["upcomingLeaves"] == null
          ? []
          : List<UpcomingAndPastLeaveModel>.from(
              json["upcomingLeaves"].map((x) => UpcomingAndPastLeaveModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leaveBalance": leaveBalance?.map((e) => e.toJson()).toList(),
      "pastLeaves": pastLeaves?.map((e) => e.toJson()).toList(),
      "upcomingLeaves": upcomingLeaves?.map((e) => e.toJson()).toList(),
    };
  }
}

class LeaveBalance {
  final String? leaveType;
  final int? totalLeaves;
  final int? usedLeaves;
  final int? balance;

  LeaveBalance({this.leaveType, this.totalLeaves, this.usedLeaves, this.balance});

  LeaveBalance copyWith({String? leaveType, int? totalLeaves, int? usedLeaves, int? balance}) {
    return LeaveBalance(
      leaveType: leaveType ?? this.leaveType,
      totalLeaves: totalLeaves ?? this.totalLeaves,
      usedLeaves: usedLeaves ?? this.usedLeaves,
      balance: balance ?? this.balance,
    );
  }

  factory LeaveBalance.fromJson(Map<String, dynamic> json) {
    return LeaveBalance(
      leaveType: json["leave_type"],
      totalLeaves: json["total_leaves"],
      usedLeaves: json["used_leaves"],
      balance: json["balance"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"leave_type": leaveType, "total_leaves": totalLeaves, "used_leaves": usedLeaves, "balance": balance};
  }
}

class UpcomingAndPastLeaveModel {
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
  final String? createdAt;
  final String? updatedAt;
  final LeavePlanType? leavePlanType;

  UpcomingAndPastLeaveModel({
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
  });

  factory UpcomingAndPastLeaveModel.fromJson(Map<String, dynamic> json) {
    return UpcomingAndPastLeaveModel(
      userAppliedLeavesId: json['user_applied_leaves_id'],
      userId: json['user_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalDays: json['total_days'],
      reason: json['reason'],
      approvedBy: json['approved_by'],
      managerComment: json['manager_comment'],
      leavePlanTypeId: json['leave_plan_type_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      leavePlanType: json['leave_plan_type'] != null ? LeavePlanType.fromJson(json['leave_plan_type']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_applied_leaves_id': userAppliedLeavesId,
      'user_id': userId,
      'start_date': startDate,
      'end_date': endDate,
      'total_days': totalDays,
      'reason': reason,
      'approved_by': approvedBy,
      'manager_comment': managerComment,
      'leave_plan_type_id': leavePlanTypeId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'leave_plan_type': leavePlanType?.toJson(),
    };
  }

  UpcomingAndPastLeaveModel copyWith({
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
    String? createdAt,
    String? updatedAt,
    LeavePlanType? leavePlanType,
  }) {
    return UpcomingAndPastLeaveModel(
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
    );
  }
}
