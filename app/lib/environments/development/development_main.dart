import '../app_start.dart';
import 'development_build_config.dart';

class DevelopmentApp extends AppStart {
  DevelopmentApp() : super(DevelopmentBuildConfig());
}

Future<void> main() => DevelopmentApp().startApp();
