import 'package:hrms_yb/core/enums/user_role.dart';
import 'package:hrms_yb/models/user_model.dart';

class AppGlobals {
  bool isDarkMode = false;
  UserModel userModel = UserModel(
    id: 1,
    name: 'HR User',
    role: UserRole.hr,
    email: 'userhr@gamil.com',
    phone: '9876543211',
  );
}
