import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../localization/task_localization.dart';

abstract class TaskBaseWidgetState<ScreenWidget extends StatefulWidget>
    extends BaseWidgetState<ScreenWidget>
    with WidgetsBindingObserver {

  late TaskLocalization appLocal;
  late String lang;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      appLocal = TaskLocalization.of(context);
      lang = appLocal.locale.languageCode;
    }
  }
}