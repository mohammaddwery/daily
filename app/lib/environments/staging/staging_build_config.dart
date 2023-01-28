import 'package:core/core.dart';

class StagingBuildConfig extends BuildConfig {
  StagingBuildConfig(): super(
    configs: {
      BuildConfig.databaseName: "dev_daily.db", // TODO
      BuildConfig.databaseVersion: 1,
    },
    environmentType: EnvironmentType.stage,
  );
}
