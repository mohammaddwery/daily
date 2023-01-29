import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class TaskLocalization extends BaseLocalization {
  TaskLocalization({
    required this.appLocale,
    required this.appPathFunction,
  }) : super(appPathFunction: appPathFunction, locale: appLocale);
  @override
  // ignore: overridden_fields
  final String Function(Locale locale) appPathFunction;
  final Locale appLocale;
  static TaskLocalization of(BuildContext context) =>
      Localizations.of<TaskLocalization>(context, TaskLocalization)!;
}

class TaskLocalizationDelegate extends LocalizationsDelegate<TaskLocalization> {
  TaskLocalizationDelegate({
    required this.supportedLocales,
    required this.getPathFunction,
  });

  final List<Locale> supportedLocales;
  final String Function(Locale locale) getPathFunction;
  late Locale locale;

  @override
  bool isSupported(Locale locale) =>
      getSupportedLocaleForLanguageCode(supportedLocales, locale) != null;

  @override
  Future<TaskLocalization> load(Locale locale) async {
    this.locale = locale;
    final localization = TaskLocalization(
      appLocale: locale,
      appPathFunction: getPathFunction,
    );

    await localization.load();

    return localization;
  }

  @override
  bool shouldReload(TaskLocalizationDelegate old) => old.locale != locale;
}
