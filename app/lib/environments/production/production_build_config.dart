import 'package:core/core.dart';

class ProductionBuildConfig extends BuildConfig {
  ProductionBuildConfig(): super(
    configs: {
      BuildConfig.databaseName: "prod_daily.db", // TODO
      BuildConfig.databaseVersion: 1,
    },
    environmentType: EnvironmentType.production,
  );
}
