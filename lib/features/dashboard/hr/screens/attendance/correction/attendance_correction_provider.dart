import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

class AttendanceCorrectionProvider extends ChangeNotifier {
  final BuildContext context;

  /// Dummy Data
  final List<String> employees = ["Manish Patel", "Rahul Sharma", "Priya Singh"];

  String? selectedEmployee = "Manish Patel";

  final TextEditingController dateController = TextEditingController(text: "19/12/2024");

  final TextEditingController punchInController = TextEditingController(text: "--:-- --");

  final TextEditingController punchOutController = TextEditingController(text: "--:-- --");

  final TextEditingController reasonController = TextEditingController(text: "");

  AttendanceCorrectionProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }

  Future<void> selectTime({required TextEditingController controller}) async {
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    /// Converts to 12-hour format with AM/PM
    final formattedTime = time?.format(context); // ignore: use_build_context_synchronously

    controller.text = "$formattedTime";
    notifyListeners();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      barrierColor: AppColors.borderGrey.withValues(alpha: 0.3),
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      dateController.text = "${date.day}/${date.month}/${date.year}";
    }
    notifyListeners();
  }
}
