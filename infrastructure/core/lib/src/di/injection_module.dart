import 'dart:async';
import '../core/build_config.dart';
import 'injector.dart';

abstract class InjectionModule {
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  });
}
