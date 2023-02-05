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

  static String getFormatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = twoDigits(duration.inDays);
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if(duration.inDays >= 1) {
      return '${twoDigitDays}d ${twoDigitHours}h ${twoDigitMinutes}m';
    } else {
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}

extension ListOperator on List {
  T? findItemBy<T, E>({
    required E Function(T item) predicate,
    required E? id,
  }) => firstWhereOrNull((item) => predicate(item) == id,);
}