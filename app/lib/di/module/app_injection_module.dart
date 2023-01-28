import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import '../../app/my_app.dart';

class AppInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector
      ..registerSingleton<BuildConfig>(buildConfig)
      ..registerSingleton<GlobalKey<NavigatorState>>(navigatorKey)
    ;
  }
}
