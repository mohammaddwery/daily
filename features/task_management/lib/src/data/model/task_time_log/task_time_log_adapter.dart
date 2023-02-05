import 'package:core/core.dart';
import 'package:task_management/src/data/model/task_time_log/create_task_time_log.dart';
import 'task_time_log.dart';

List<TaskTimeLog> adaptMapsToTasksTimeLog(List<Map<String, dynamic>> maps,)
=> List<TaskTimeLog>.from(maps.map((e) => adaptMapToTaskTimeLog(e)));

TaskTimeLog adaptMapToTaskTimeLog(Map<String, dynamic> map,) => TaskTimeLog(
  id: map[TaskTimeLogScheme.columnId],
  taskId: map[TaskTimeLogScheme.columnTaskId],
  start: DateTime.parse(map[TaskTimeLogScheme.columnStart]).toLocal(),
  end: map[TaskTimeLogScheme.columnEnd] == null
      ? null
      : DateTime.parse(map[TaskTimeLogScheme.columnEnd]).toLocal(),
);

Map<String, dynamic> adaptTaskTimeLogToMap(TaskTimeLog log) => {
  TaskTimeLogScheme.columnId: log.id,
  TaskTimeLogScheme.columnTaskId: log.taskId,
  TaskTimeLogScheme.columnStart: log.start.toIso8601String(),
  TaskTimeLogScheme.columnEnd: log.end?.toIso8601String(),
};

Map<String, dynamic> adaptCreateTaskTimeLogToMap(CreateTaskTimeLog log) => {
  TaskTimeLogScheme.columnTaskId: log.taskId,
  TaskTimeLogScheme.columnStart: log.start.toIso8601String(),
};

Map<String, dynamic> adaptStopTaskTimeLogToMap() => {
  TaskTimeLogScheme.columnEnd: DateTime.now().toIso8601String(),
};

