import 'package:core/core.dart';
import '../di/module/app_injection_module.dart';

class AppResolver extends FeatureResolver {
  @override
  InjectionModule? get injectionModule => AppInjectionModule();
}
