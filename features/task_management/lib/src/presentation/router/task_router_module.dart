import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';
import '../screen/home_screen/home_screen.dart';

class TaskRouterModule implements RouterModule {
  @override
  Map<String, MaterialPageRoute> getRoutes(RouteSettings settings) =>
      <String, MaterialPageRoute> {
        TaskRoutes.homeScreen: MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        ),
      };
}
