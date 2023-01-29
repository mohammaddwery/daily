import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'di/task_injection_module.dart';
import 'presentation/localization/task_delegate.dart';
import 'presentation/router/task_router_module.dart';

class TaskResolver extends FeatureResolver {

  @override
  InjectionModule? get injectionModule => TaskInjectionModule();

  @override
  RouterModule? get routerModule => TaskRouterModule();

  @override
  LocalizationsDelegate? get localeDelegate => taskLocalizationDelegate;

}
