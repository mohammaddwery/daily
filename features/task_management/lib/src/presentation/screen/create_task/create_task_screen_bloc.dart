import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task/task.dart';
import '../upsert_task/upsert_task_screen_bloc.dart';
import '../../../data/model/task/create_task.dart';

class CreateTaskScreenBloc extends UpsertTaskScreenBloc {
  final UseCase<Task, CreateTask> _createTaskLocallyUseCase;
  CreateTaskScreenBloc({
    required UseCase<Task, CreateTask> createTaskLocallyUseCase,
    required super.getLocalTaskStatesUseCase,
    required super.getLocalTaskLabelsUseCase,
  }): _createTaskLocallyUseCase = createTaskLocallyUseCase;

  @override
  upsertTask(BuildContext context) => handleCrudDataItem<Task>(
    exceptionTag: 'CreateTaskScreenBloc create task()',
    crudDataItem: () async => await _createTaskLocallyUseCase.call(createTask),
    onSucceed: (task) => onUpsertTaskSucceed<Task>(context, task),
    onFailed: onUpsertTaskFailed,
  );
}