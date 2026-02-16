class PayslipModel {
  final String id;
  final String month;
  final int year;
  final double grossSalary;
  final double netPay;
  final String? fileUrl;
  final bool isDownloaded;

  const PayslipModel({
    required this.id,
    required this.month,
    required this.year,
    required this.grossSalary,
    required this.netPay,
    this.fileUrl,
    this.isDownloaded = false,
  });

  /// copyWith
  PayslipModel copyWith({
    String? id,
    String? month,
    int? year,
    double? grossSalary,
    double? netPay,
    String? fileUrl,
    bool? isDownloaded,
  }) {
    return PayslipModel(
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      grossSalary: grossSalary ?? this.grossSalary,
      netPay: netPay ?? this.netPay,
      fileUrl: fileUrl ?? this.fileUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
