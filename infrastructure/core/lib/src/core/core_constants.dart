import 'package:flutter/material.dart';

const List<Locale> appSupportedLocales = [
  Locale('en'),
];

class CoreConstants {
  static const String packageName = 'core';
  static const String generalErrorMessageKey = 'something_went_wrong';
  static const String connectionErrorMessageKey = 'connection_error';
  static const String timeoutMessageKey = 'timeout';
}