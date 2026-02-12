import 'package:flutter/material.dart';
import 'package:hrms_yb/core/enums/user_role.dart';
import 'package:hrms_yb/models/user_model.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  TextEditingController emailController = TextEditingController(text: "useremploye@gamil.com");
  TextEditingController pinController = TextEditingController(text: "1234");

  LoginProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {}

  Future<bool?> login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    // Demo logic
    if (email.contains('hr')) {
      _user = UserModel(id: 1, name: 'HR User', role: UserRole.hr, email: 'userhr@gamil.com', phone: '9876543211');
    } else {
      _user = UserModel(
        id: 2,
        name: 'Employee User',
        role: UserRole.employee,
        email: 'useremploye@gamil.com',
        phone: '9999999999',
      );
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
