import 'package:flutter/material.dart';

String getTranslationFilePath({
  required Locale locale,
  String? packageName,
}) =>
    packageName != null
        ? 'packages/$packageName/assets/subtitles/${locale.languageCode}.json'
        : 'assets/subtitles/${locale.languageCode}.json';
