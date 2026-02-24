class HolidayModel {
  final int? holidayId;
  final String? holidayDate;
  final int? month;
  final int? year;
  final String? holidayType;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HolidayModel({
    this.holidayId,
    this.holidayDate,
    this.month,
    this.year,
    this.holidayType,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  /// copyWith
  HolidayModel copyWith({
    int? holidayId,
    String? holidayDate,
    int? month,
    int? year,
    String? holidayType,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HolidayModel(
      holidayId: holidayId ?? this.holidayId,
      holidayDate: holidayDate ?? this.holidayDate,
      month: month ?? this.month,
      year: year ?? this.year,
      holidayType: holidayType ?? this.holidayType,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      holidayId: json['holiday_id'],
      holidayDate: json['holiday_date'],
      month: json['month'],
      year: json['year'],
      holidayType: json['holiday_type'],
      title: json['title'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "holiday_id": holidayId,
      "holiday_date": holidayDate,
      "month": month,
      "year": year,
      "holiday_type": holidayType,
      "title": title,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}
