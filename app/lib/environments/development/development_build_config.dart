import 'package:core/core.dart';

class DevelopmentBuildConfig extends BuildConfig {
  DevelopmentBuildConfig(): super(
    configs: {
      BuildConfig.databaseName: "dev_daily.db",
      BuildConfig.databaseVersion: 1,
    },
    environmentType: EnvironmentType.development,
  );
}
