import 'package:flutter/material.dart';

class TaskRoutes {
  TaskRoutes._();

  static const String homeScreen = '/';
  static const String _task = 'task';
  static const String createTask = '$_task/create';
  static const String updateTask = '$_task/update';
}

abstract class TaskNavigator {
  Future navigateToCreateTaskScreen(BuildContext context, Object state);
  Future navigateToUpdateTaskScreen(BuildContext context, Object task);
}