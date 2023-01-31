import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/task_management.dart';
import '../app/my_app.dart';
import '../di/app_component.dart';
import '../resolvers/app_resolver.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



abstract class AppStart {
  final BuildConfig buildConfig;

  /// The order of initialization matters, otherwise you will end up with
  /// an exception because of gitIt registration.
  final resolvers = <FeatureResolver>[
    // App
    AppResolver(),

    TaskResolver(),
  ];

  AppStart(this.buildConfig);

  Future<void> startApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    final routerModules = <RouterModule>[];

    final localDelegates = <LocalizationsDelegate>[
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
    final injections = <InjectionModule>[];

    for (final resolver in resolvers) {
      if (resolver.routerModule != null) {
        routerModules.add(resolver.routerModule!);
      }

      if (resolver.localeDelegate != null) {
        localDelegates.add(resolver.localeDelegate!);
      }

      if (resolver.injectionModule != null) {
        injections.add(resolver.injectionModule!);
      }
    }

    await AppInjectionComponent.instance.registerModules(
      config: buildConfig,
      modules: injections,
    );


    /// Initialize database
    if(buildConfig.getString(BuildConfig.databaseName)!=null) {
      await AppInjector.I.get<DatabaseManager>().dropDatabase(
        buildConfig.getString(BuildConfig.databaseName)!,
      );

      await AppInjector.I.get<DatabaseManager>().open(
        buildConfig.getString(BuildConfig.databaseName)!,
        buildConfig.getInt(BuildConfig.databaseVersion)??1,
      );
    }

    await runZonedGuarded<Future<void>>(
      () async {
        runApp(MyApp(
          buildConfig: buildConfig,
          routes: routerModules,
          localeDelegates: localDelegates,
        ));
      },
      (_, onError) {
        debugPrint('runZonedGuarded() MyApp ${onError.toString()}');
      },
    );
  }
}
