enum AttendanceStatus { present, absent, holiday, leave }

class AttendanceModel {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceModel({required this.date, required this.status});
}
