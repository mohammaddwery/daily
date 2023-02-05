import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task/task.dart';
import '../../../data/model/task_time_log/task_time_log.dart';
import '../../../domain/use_case/time_log/stop_task_time_log_use_case.dart';
import '../../../domain/use_case/update_task_use_case_param.dart';
import '../upsert_task/upsert_task_screen_bloc.dart';


class UpdateTaskScreenBloc extends UpsertTaskScreenBloc {
  final UseCase<Task, UpdateTaskUseCaseParam> _updateTaskLocallyUseCase;
  final UseCase<List<TaskTimeLog>, int> _getTaskTimeLogsUseCase;
  final StopTaskTimeLogUseCase _stopTaskTimeLogUseCase;
  final Task _task;
  UpdateTaskScreenBloc({
    required super.getLocalTaskStatesUseCase,
    required super.getLocalTaskLabelsUseCase,
    required Task task,
    required UseCase<Task, UpdateTaskUseCaseParam> updateTaskLocallyUseCase,
    required UseCase<List<TaskTimeLog>, int> getTaskTimeLogsUseCase,
    required StopTaskTimeLogUseCase stopTaskTimeLogUseCase,
  }): _updateTaskLocallyUseCase = updateTaskLocallyUseCase,
        _getTaskTimeLogsUseCase = getTaskTimeLogsUseCase,
        _stopTaskTimeLogUseCase = stopTaskTimeLogUseCase,
        _task = task {
    _initializeWidgetsDefaultValues();
  }

  void _initializeWidgetsDefaultValues() {
    selectedTaskStateController.setValue(_task.state.name);
    taskTitleTextEditingController.text = _task.title;
    taskDescriptionTextEditingController.text = _task.description??'';
    selectedTaskLabelController.setValue(_task.label?.name);
  }

  @override
  upsertTask(BuildContext context) => handleCrudDataItem<Task>(
    exceptionTag: 'UpdateTaskScreenBloc updateTask()',
    crudDataItem: () async {
      UpdateTaskUseCaseParam param = _updateTaskUserCaseParam;
      /// When user updates task's state, task's time log must stop.
      if(param.task.stateId != _task.state.id) {
        await _stopTaskTimeLog(param.id);
      }
      return await _updateTaskLocallyUseCase.call(param);
    },
    onSucceed: (task) => onUpsertTaskSucceed(context, task),
    onFailed: onUpsertTaskFailed,
  );

  Future _stopTaskTimeLog(int taskId) async => await _getTaskTimeLogsUseCase
        .call(taskId)
        .then((value) async {
      if(value.playingLogs.isNotEmpty) {
        await _stopTaskTimeLogUseCase.call(taskId).catchError((error) {
          debugPrint("UpdateTaskScreenBloc _stopTaskTimeLog() $error");
        });
      }
    }).catchError((error) {
      debugPrint("UpdateTaskScreenBloc _getTaskTimeLogsUseCase() $error");
    });

  UpdateTaskUseCaseParam get _updateTaskUserCaseParam => UpdateTaskUseCaseParam(
    id: _task.id,
    task: createTask,
  );
}