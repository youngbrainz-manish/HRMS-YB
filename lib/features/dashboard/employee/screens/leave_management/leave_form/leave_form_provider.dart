import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class LeaveFormProvider extends ChangeNotifier {
  final BuildContext context;

  String leaveType = "Select leave type";
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final reason = TextEditingController();

  final ImagePicker picker = ImagePicker();
  List<File> pickedFile = [];

  Future<void> pickDate(TextEditingController controller) async {
    final date = await showDatePicker(
      barrierColor: AppColors.borderGrey.withValues(alpha: 0.3),
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      controller.text = "${date.day}/${date.month}/${date.year}";
    }
  }

  LeaveFormProvider({required this.context}) {
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

  void pickFile() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedFile.add(File(file.path));
    }
    notifyListeners();
  }
}
