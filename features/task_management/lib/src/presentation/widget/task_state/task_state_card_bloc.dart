import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';
import '../../../data/model/task/task.dart';
import '../../../data/model/task_state/task_state.dart';

class TaskStateCardBloc extends CrudDataBlocHandler {
  final TaskNavigator _taskNavigator;
  TaskStateCardBloc({
    required TaskNavigator taskNavigator,
    required List<Task> tasks,
  }): _taskNavigator = taskNavigator {
    tasksController.setValue(tasks);
  }

  final tasksController = SeededBehaviorSubjectComponent<List<Task>>([]);

  void onCreateTaskClicked({
    required BuildContext context,
    required TaskState state,
    required Function(Task task) onDoneCallback
  }) => _taskNavigator
      .navigateToCreateTaskScreen(context, state)
      .then((task) {
    if(task == null) return;

    if(task.state.id == state.id) {
      /// insert the created task in the same task's state card
      tasksController.setValue(tasksController.getValue()..add(task));
    } else {
      onDoneCallback(task);
    }
  });

  void onUpdateTaskClicked({
    required BuildContext context,
    required Task task,
    required Function(Task task) onDoneCallback
  }) => _taskNavigator.navigateToUpdateTaskScreen(context, task).then((updatedTask) {
    if(updatedTask == null) return;

    List<Task> tasks = List.of(tasksController.getValue());
    int index = tasks.indexWhere((element) => element.id == updatedTask.id);
    tasks.removeAt(index);

    if(task.state.id == updatedTask.state.id) {
      /// insert the updated task in the same task's state card
      /// after removing the old variant of it (replace mechanism)
      tasks.insert(index, updatedTask);
    } else {
      onDoneCallback(updatedTask);
    }

    tasksController.setValue(tasks);
  });

  dispose() {
    tasksController.dispose();
  }
}