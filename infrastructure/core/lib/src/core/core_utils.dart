import 'package:flutter/services.dart';
import '../data/adapters/json_adapter.dart';
import 'package:collection/collection.dart';

class CoreUtils {

  static Future readJsonFile(String path) async {
    try {
      final String response = await rootBundle.loadString(path);
      return decodeJson(response);
    } catch(e) {
     throw FormatException('readJsonFile() Error: ${e.toString()}');
    }
  }

  static int parseObjectIntoInt(object) => int.parse(object.toString());
}

extension ListOperator on List {
  T? findItemBy<T, E>({
    required E Function(T item) predicate,
    required E? id,
  }) => firstWhereOrNull((item) => predicate(item) == id,);
}