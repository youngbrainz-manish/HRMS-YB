import 'env_file.dart';

class DioApiServices {
  static String baseUrl = Environment().getStrings('base_url');

  static const String login = 'auth/login';
  static const String getUserById = 'employees';
}
