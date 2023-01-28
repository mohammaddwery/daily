
import '../app_start.dart';
import 'staging_build_config.dart';

class StagingApp extends AppStart {
  StagingApp() : super(StagingBuildConfig());
}

Future<void> main() => StagingApp().startApp();
