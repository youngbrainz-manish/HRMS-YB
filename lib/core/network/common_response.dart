class CommonResponse {
  // int? status;
  bool? success;
  String? message;

  CommonResponse({
    // this.status,
    this.success,
    this.message,
  });

  CommonResponse.fromJson(Map<String, dynamic> json) {
    // status = json['status_code'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
