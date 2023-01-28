import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
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
