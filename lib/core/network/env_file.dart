// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum EnvironmentMode { PROD, DEV }

class Environment {
  static EnvironmentMode environmentMode = EnvironmentMode.PROD;
  static String version = "v1";

  getStrings(String keyName) {
    try {
      if (environmentMode == EnvironmentMode.DEV) {
        if (kDebugMode && !kIsWeb) {
          debugPrint("chats === $keyName");
        }
        Map<String, dynamic> buildValues = {'base_url': 'https://prescriptive-slumberously-giana.ngrok-free.dev/api/'};

        return buildValues[keyName];
      } else if (environmentMode == EnvironmentMode.PROD) {
        Map<String, dynamic> buildValues = {'base_url': 'https://hrmsapi.ybtest.co.in/api/'};

        return buildValues[keyName];
      }
    } catch (e) {
      if (kDebugMode && !kIsWeb) {
        debugPrint("Exception == $e");
      }
      return null;
    }
  }
}
