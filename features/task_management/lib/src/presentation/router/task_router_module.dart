import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';
import '../../data/model/task/task.dart';
import '../screen/create_task/create_task_screen.dart';
import '../screen/home_screen/home_screen.dart';
import '../screen/update_task/update_task_screen.dart';

class TaskRouterModule implements RouterModule {
  @override
  Map<String, MaterialPageRoute> getRoutes(RouteSettings settings) =>
      <String, MaterialPageRoute> {
        TaskRoutes.homeScreen: MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        ),
        TaskRoutes.createTask: MaterialPageRoute(
          builder: (_) => const CreateTaskScreen(),
          settings: settings,
        ),
        TaskRoutes.updateTask: MaterialPageRoute(
          builder: (_) => UpdateTaskScreen(settings.arguments as Task),
          settings: settings,
        ),
      };
}
