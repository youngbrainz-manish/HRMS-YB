import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_model.dart';

class AttendanceHistoryModel {
  final DateTime date;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final AttendanceStatus status;

  const AttendanceHistoryModel({required this.date, required this.status, this.checkIn, this.checkOut});

  /// Duration in hours (e.g. 9.08 hrs)
  double? get workedHours {
    if (checkIn == null || checkOut == null) return null;

    final difference = checkOut!.difference(checkIn!);
    final hours = difference.inMinutes / 60;
    return double.parse(hours.toStringAsFixed(2));
  }

  /// CopyWith
  AttendanceHistoryModel copyWith({DateTime? date, DateTime? checkIn, DateTime? checkOut, AttendanceStatus? status}) {
    return AttendanceHistoryModel(
      date: date ?? this.date,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      status: status ?? this.status,
    );
  }
}
