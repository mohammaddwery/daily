import 'dart:async';
import 'package:core/core.dart';
import 'package:task_management/src/domain/use_case/time_log/stop_task_time_log_use_case.dart';
import '../../../domain/use_case/time_log/create_task_time_log_use_case.dart';
import '../../../data/model/task_time_log/task_time_log.dart';
import 'task_timer.dart';

class TaskCardTimerBloc extends CrudDataBlocHandler {
  final UseCase<List<TaskTimeLog>, int> _getTaskTimeLogsUseCase;
  final UseCase<List<TaskTimeLog>, NoParams> _getTasksTimeLogUseCase;
  final CreateTaskTimeLogUseCase _createTaskTimeLogUseCase;
  final StopTaskTimeLogUseCase _stopTaskTimeLogUseCase;
  final int _taskId;
  TaskCardTimerBloc({
    required UseCase<List<TaskTimeLog>, int> getTaskTimeLogsUseCase,
    required UseCase<List<TaskTimeLog>, NoParams> getTasksTimeLogUseCase,
    required CreateTaskTimeLogUseCase createTaskTimeLogUseCase,
    required StopTaskTimeLogUseCase stopTaskTimeLogUseCase,
    required int taskId,
  }): _taskId = taskId,
        _getTaskTimeLogsUseCase = getTaskTimeLogsUseCase,
        _getTasksTimeLogUseCase = getTasksTimeLogUseCase,
        _stopTaskTimeLogUseCase = stopTaskTimeLogUseCase,
        _createTaskTimeLogUseCase = createTaskTimeLogUseCase {
    initTimer();
  }

  List<TaskTimeLog> taskTimeLogs = [];
  final currentTaskTimerController = BehaviorSubjectComponent<TaskTimer?>();
  final timerInterval = const Duration(seconds: 1);
  Timer? _timer;

  void initTimer() => _getTaskTimeLogs();

  _getTaskTimeLogs() => handleVoidCrudDataItem(
    exceptionTag: 'TaskCardTimerBloc _getTaskTimeLogs()',
    voidCrudDataItem: () async {
      taskTimeLogs = await _getTaskTimeLogsUseCase.call(_taskId);

      if(taskTimeLogs.isEmpty) {
        return;
      }

      if(taskTimeLogs.playingLogs.isNotEmpty) {
        _createTimer();
        return;
      }

      _updateTaskTimer(false);
    },
  );

  _updateTaskTimer(bool playing) {
    currentTaskTimerController.setValue(
        TaskTimer(
          duration: _calculateDuration(taskTimeLogs),
          formatDuration: taskTimeLogs.formatDuration,
          playing: playing,
        )
    );
  }

  _createTimer() {
    _timer = Timer.periodic(timerInterval, (_) {
      _updateTaskTimer(true);
    });
  }

  Duration _calculateDuration(List<TaskTimeLog> taskTimeLogs) {
    return taskTimeLogs.duration + timerInterval;
  }

  void switchTimerState() async {
    bool switchable = await _canSwitchTimerState();
    if(!switchable) return;

    /// Start timer
    if(!(_timer?.isActive??false)) {
      _startTimer();
      return;
    }

    /// Stop timer
    _stopTimer();
  }

  Future<bool> _canSwitchTimerState() async {
    List<TaskTimeLog> tasksTimeLog = await _getTasksTimeLogUseCase.call(NoParams());
    List<TaskTimeLog> tasksPlayingTimeLog = tasksTimeLog.playingLogs;
    List<TaskTimeLog> currentTaskPlayingTimeLogs = tasksPlayingTimeLog.getLogs(_taskId);

    /// You can't run more than single timer.
    if(tasksPlayingTimeLog.isNotEmpty &&
        currentTaskPlayingTimeLogs.isEmpty) {
      ToastHelper.showToast('You\'ve already tracked a task before. You can\'t track more than single task in the same time.');
      return false;
    }

    return true;
  }

  _startTimer() async {
    TaskTimeLog createdLog = await _createTaskTimeLogUseCase.call(_taskId);
    taskTimeLogs.add(createdLog);
    _createTimer();
  }

  _stopTimer() => handleVoidCrudDataItem(
    exceptionTag: 'TaskCardTimerBloc _stopTimer()',
    voidCrudDataItem: () async {
      TaskTimeLog updatedLog = await _stopTaskTimeLogUseCase.call(_taskId);
      taskTimeLogs.removeWhere((element) => element.taskId == updatedLog.taskId);
      taskTimeLogs.add(updatedLog);

      _timer!.cancel();
      currentTaskTimerController.setValue(
          currentTaskTimerController.getValue()!.copy(playing: false,)
      );
    },
  );

  @override
  void dispose() {}
}