class LeaveSummaryModel {
  final bool? success;
  final String? message;
  final LeaveSummaryData? data;

  LeaveSummaryModel({this.success, this.message, this.data});

  LeaveSummaryModel copyWith({
    bool? success,
    String? message,
    LeaveSummaryData? data,
  }) {
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
      data: json["data"] != null
          ? LeaveSummaryData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data?.toJson()};
  }
}

class LeaveSummaryData {
  final List<LeaveBalance>? leaveBalance;
  final List<PastLeave>? pastLeaves;
  final List<PastLeave>? upcomingLeaves;

  LeaveSummaryData({this.leaveBalance, this.pastLeaves, this.upcomingLeaves});

  LeaveSummaryData copyWith({
    List<LeaveBalance>? leaveBalance,
    List<PastLeave>? pastLeaves,
    List<PastLeave>? upcomingLeaves,
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
          : List<LeaveBalance>.from(
              json["leaveBalance"].map((x) => LeaveBalance.fromJson(x)),
            ),
      pastLeaves: json["pastLeaves"] == null
          ? []
          : List<PastLeave>.from(
              json["pastLeaves"].map((x) => PastLeave.fromJson(x)),
            ),
      upcomingLeaves: json["upcomingLeaves"] == null
          ? []
          : List<PastLeave>.from(
              json["upcomingLeaves"].map((x) => PastLeave.fromJson(x)),
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

  LeaveBalance({
    this.leaveType,
    this.totalLeaves,
    this.usedLeaves,
    this.balance,
  });

  LeaveBalance copyWith({
    String? leaveType,
    int? totalLeaves,
    int? usedLeaves,
    int? balance,
  }) {
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
    return {
      "leave_type": leaveType,
      "total_leaves": totalLeaves,
      "used_leaves": usedLeaves,
      "balance": balance,
    };
  }
}

class PastLeave {
  PastLeave();

  PastLeave copyWith() {
    return PastLeave();
  }

  factory PastLeave.fromJson(Map<String, dynamic> json) {
    return PastLeave();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
