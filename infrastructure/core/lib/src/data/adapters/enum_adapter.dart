import 'package:collection/collection.dart';

String adaptEnumToString<T>(T item) => item.toString().split('.').last;
T? adaptStringToEnum<T>(String key, List<T> values) => values
    .firstWhereOrNull((item) => key == adaptEnumToString<T>(item));