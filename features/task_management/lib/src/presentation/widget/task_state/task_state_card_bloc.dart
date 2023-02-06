import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:core/core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/model/task/task.dart';
import '../../../data/model/task/task_adapter.dart';
import '../../../data/model/task_state/task_state.dart';

class TaskStateCardBloc extends CrudDataBlocHandler {
  final TaskNavigator _taskNavigator;
  final TaskState _taskState;
  TaskStateCardBloc({
    required TaskNavigator taskNavigator,
    required TaskState state,
  }): _taskNavigator = taskNavigator, _taskState = state {
    tasksController.setValue(state.tasks);
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

  onExportCsvClicked() => handleVoidCrudDataItem(
    exceptionTag: 'onExportCsvClicked()',
    onFailed: _onExportFailed,
    voidCrudDataItem: () async => await _exportCsvFile(
      columnsName: _taskCsvColumns,
      entries: adaptTasksToCsvEntries(_taskState.tasks),
    ),
  );

  final _taskCsvColumns = [
    TaskScheme.columnId,
    TaskScheme.columnTitle,
    TaskScheme.columnDescription,
    TaskLabelScheme.tableName,
    TaskStateScheme.tableName,
    TaskScheme.columnCreatedAt,
  ];

  _onExportFailed(String message) {
    ToastHelper.showToast(message);
  }

  _exportCsvFile({
    required List<String> columnsName,
    required List<List<dynamic>> entries,
  }) async {
    if (!await Permission.storage.request().isGranted) return;

    Directory tempDirectory = await getTemporaryDirectory();
    String? tempDirectoryPath = tempDirectory.path;
    final filePath = "$tempDirectoryPath${_taskState.name}${_taskState.id}_${DateTime.now().toIso8601String()}.csv";
    File file = File(filePath);
    String csvData = const ListToCsvConverter().convert([
      columnsName,
      ...entries,
    ]);
    File csvFile = await file.writeAsString(csvData);
    Share.shareXFiles(
      [ XFile(csvFile.path), ],
      text: 'Checkout my daily tasks',
    ).then((value) {
      csvFile.delete();
    });
  }

  @override
  dispose() {
    tasksController.dispose();
  }
}