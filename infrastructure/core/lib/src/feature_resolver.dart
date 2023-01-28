import 'package:core/src/di/injection_module.dart';
import 'package:core/src/presentation/router/router_module.dart';
import 'package:flutter/material.dart';

abstract class FeatureResolver {
  RouterModule? get routerModule => null;

  LocalizationsDelegate? get localeDelegate => null;

  InjectionModule? get injectionModule => null;
}
