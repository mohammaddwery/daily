import 'package:core/core.dart';

import 'create_task_time_log.dart';

class TaskTimeLog extends CreateTaskTimeLog {
  final int id;
  final DateTime? end;
  TaskTimeLog({
    required this.id,
    required super.taskId,
    required super.start,
    this.end,
  });

  TaskTimeLog copy({
    int? id,
    DateTime? start,
    DateTime? end,
    int? taskId,
  }) => TaskTimeLog(
    id: id??this.id,
    start: start??this.start,
    end: end??this.end,
    taskId: taskId??this.taskId,
  );
}

extension TaskTimeLogExtension on TaskTimeLog {
  Duration get duration => (end??DateTime.now()).difference(start);
  String get formatDuration => CoreUtils.getFormatDuration(duration);
  bool get playing => (end == null);
}

extension TasksTimeLogExtension on List<TaskTimeLog> {
  List<TaskTimeLog> getLogs(int taskId) => where((element) => element.taskId == taskId).toList();

  List<TaskTimeLog> get playingLogs => where((element) => element.playing).toList();

  List<TaskTimeLog> get pausedLogs =>
      where((element) => !element.playing).toList();

  Duration get duration =>
      map((e) => e.duration).reduce((value, element) => (value + element));

  String get formatDuration => CoreUtils.getFormatDuration(duration);
}