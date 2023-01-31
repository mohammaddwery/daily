
import 'package:flutter/services.dart';

import '../data/adapters/json_adapter.dart';

class CoreUtils {

  static Future readJsonFile(String path) async {
    try {
      final String response = await rootBundle.loadString(path);
      return decodeJson(response);
    } catch(e) {
     throw FormatException('readJsonFile() Error: ${e.toString()}');
    }
  }
}