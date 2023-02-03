import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';

class AppTaskNavigator with AppNavigator implements TaskNavigator {
  @override
  Future navigateToCreateTaskScreen(BuildContext context, Object state) => navigateTo(
    context: context,
    routeName: TaskRoutes.createTask,
    arguments: state,
  );

  @override
  Future navigateToUpdateTaskScreen(BuildContext context, Object task) => navigateTo(
    context: context,
    routeName: TaskRoutes.updateTask,
    arguments: task,
  );
}
