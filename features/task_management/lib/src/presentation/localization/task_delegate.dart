import 'package:core/core.dart';
import '../../core/task_constants.dart';
import 'task_localization.dart';

final taskLocalizationDelegate = TaskLocalizationDelegate(
  getPathFunction: (locale) => getTranslationFilePath(packageName: TaskConstants.packageName , locale: locale),
  supportedLocales: appSupportedLocales,
);
