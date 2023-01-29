import 'package:core/core.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final List<LocalizationsDelegate> localeDelegates;
  final List<RouterModule> routes;
  final BuildConfig buildConfig;

  const MyApp({
    required this.localeDelegates,
    required this.routes,
    required this.buildConfig,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => MaterialApp(
    onGenerateRoute: (settings) => generateRoute(
      settings: settings,
      routes: routes,
    ),
    navigatorKey: navigatorKey,
    theme: AppThemeFactory().getAppThemeData(),
    localeResolutionCallback: localeResolutionCallback,
    supportedLocales: appSupportedLocales,
    localizationsDelegates: localeDelegates,
    debugShowCheckedModeBanner: buildConfig.environmentType == EnvironmentType.development,
  );

  Route<dynamic>? generateRoute({
    required List<RouterModule> routes,
    required RouteSettings settings,
  }) {
    final routesMap = <String, MaterialPageRoute>{};
    for (final route in routes) {
      routesMap.addAll(route.getRoutes(settings));
    }
    return routesMap[settings.name];
  }
}
