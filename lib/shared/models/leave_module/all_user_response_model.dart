class AllUserResponseModel {
  bool? success;
  String? message;
  LeaveDataModel? leaveDataModel;

  AllUserResponseModel({this.success, this.message, this.leaveDataModel});

  AllUserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    leaveDataModel = json['data'] != null ? LeaveDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (leaveDataModel != null) {
      data['data'] = leaveDataModel!.toJson();
    }
    return data;
  }
}

class LeaveDataModel {
  List<LeaveModel>? leaveModelList;
  int? totalRecords;
  int? totalPages;
  int? currentPage;
  int? limit;

  LeaveDataModel({this.leaveModelList, this.totalRecords, this.totalPages, this.currentPage, this.limit});

  LeaveDataModel.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaveModelList = <LeaveModel>[];
      json['leaves'].forEach((v) {
        leaveModelList!.add(LeaveModel.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (leaveModelList != null) {
      data['leaves'] = leaveModelList!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = totalRecords;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['limit'] = limit;
    return data;
  }
}

class LeaveModel {
  int? userAppliedLeavesId;
  int? userId;
  String? startDate;
  String? endDate;
  int? totalDays;
  String? reason;
  int? approvedBy;
  String? managerComment;
  int? leavePlanTypeId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Employee? employee;
  LeavePlanType? leavePlanType;

  LeaveModel({
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
    this.employee,
    this.leavePlanType,
  });

  LeaveModel.fromJson(Map<String, dynamic> json) {
    userAppliedLeavesId = json['user_applied_leaves_id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalDays = json['total_days'];
    reason = json['reason'];
    approvedBy = json['approved_by'];
    managerComment = json['manager_comment'];
    leavePlanTypeId = json['leave_plan_type_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    leavePlanType = json['leave_plan_type'] != null ? LeavePlanType.fromJson(json['leave_plan_type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_applied_leaves_id'] = userAppliedLeavesId;
    data['user_id'] = userId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['total_days'] = totalDays;
    data['reason'] = reason;
    data['approved_by'] = approvedBy;
    data['manager_comment'] = managerComment;
    data['leave_plan_type_id'] = leavePlanTypeId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (employee != null) {
      data['employee'] = employee!.toJson();
    }

    if (leavePlanType != null) {
      data['leave_plan_type'] = leavePlanType!.toJson();
    }

    return data;
  }
}

class Employee {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;

  Employee({this.userId, this.firstName, this.lastName, this.email});

  Employee.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}

class LeavePlanType {
  int? leavePlanTypeId;
  String? leaveType;
  int? leaveCount;

  LeavePlanType({this.leavePlanTypeId, this.leaveType, this.leaveCount});

  LeavePlanType.fromJson(Map<String, dynamic> json) {
    leavePlanTypeId = json['leave_plan_type_id'];
    leaveType = json['leave_type'];
    leaveCount = json['leave_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['leave_plan_type_id'] = leavePlanTypeId;
    data['leave_type'] = leaveType;
    data['leave_count'] = leaveCount;
    return data;
  }
}
