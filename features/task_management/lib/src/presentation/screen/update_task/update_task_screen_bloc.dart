import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task/task.dart';
import '../../../domain/use_case/update_task_use_case_param.dart';
import '../upsert_task/upsert_task_screen_bloc.dart';


class UpdateTaskScreenBloc extends UpsertTaskScreenBloc {
  final UseCase<Task, UpdateTaskUseCaseParam> _updateTaskLocallyUseCase;
  UpdateTaskScreenBloc({
    required UseCase<Task, UpdateTaskUseCaseParam> updateTaskLocallyUseCase,
    required super.getLocalTaskStatesUseCase,
    required super.getLocalTaskLabelsUseCase,
    required Task task,
  }): _updateTaskLocallyUseCase = updateTaskLocallyUseCase {
    _taskId = task.id;
    _initializeWidgetsDefaultValues(task);
  }

  late int _taskId;

  void _initializeWidgetsDefaultValues(Task task) {
    selectedTaskStateController.setValue(task.state.name);
    taskTitleTextEditingController.text = task.title;
    taskDescriptionTextEditingController.text = task.description??'';
    selectedTaskLabelController.setValue(task.label?.name);
  }

  @override
  upsertTask(BuildContext context) => handleCrudDataItem<Task>(
    exceptionTag: 'UpdateTaskScreenBloc updateTask()',
    crudDataItem: () async => await _updateTaskLocallyUseCase.call(_updateTaskUserCaseParam),
    onSucceed: (task) => onUpsertTaskSucceed(context, task),
    onFailed: onUpsertTaskFailed,
  );

  UpdateTaskUseCaseParam get _updateTaskUserCaseParam => UpdateTaskUseCaseParam(
    id: _taskId,
    task: createTask,
  );
}