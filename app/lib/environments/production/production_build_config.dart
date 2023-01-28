import 'package:core/core.dart';

class ProductionBuildConfig extends BuildConfig {
  ProductionBuildConfig(): super(
    configs: {
      BuildConfig.databaseName: "dev_daily.db", // TODO
      BuildConfig.databaseVersion: 1,
    },
    environmentType: EnvironmentType.production,
  );
}
