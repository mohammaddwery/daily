import 'package:core/core.dart';
import 'package:task_management/src/data/model/task_time_log/create_task_time_log.dart';
import 'package:task_management/src/data/model/task_time_log/task_time_log.dart';
import '../../model/label/task_label.dart';
import '../../model/task/create_task.dart';
import '../../model/task/task.dart';
import '../../model/task/task_adapter.dart';
import '../../model/task_state/task_state_adapter.dart';
import '../../model/label/task_label_adapter.dart';
import '../../model/task_state/task_state.dart';
import '../../model/task_time_log/task_time_log_adapter.dart';
import 'task_database_provider.dart';

class AppTaskDatabaseProvider extends TaskDatabaseProvider {
  final DatabaseManager _databaseManager;
  AppTaskDatabaseProvider({
    required DatabaseManager databaseManager,
  }): _databaseManager = databaseManager;


  /// Task's State

  @override
  Future<List<TaskState>> getTaskStatesWithTasks() async {
    final taskStates = await getTaskStates();
    final tasks = await getTasks();
    return taskStates.map((state) => TaskState(
      id: state.id,
      name: state.name,
      tasks: tasks.where((task) => task.state.id == state.id).toList(),
    )).toList();
  }

  @override
  Future<List<TaskState>> getTaskStates() async {
    List<Map<String, dynamic>> statesResponse = await _databaseManager.query(TaskStateScheme.tableName,);
    if(statesResponse.isEmpty) throw const FormatException('No task\'s states with found');

    return adaptMapListToTaskStates(statesResponse);
  }

  @override
  Future<TaskState> getTaskState(int taskStateId) async {
    final response = await _databaseManager.query(
      TaskStateScheme.tableName,
      where: '${TaskStateScheme.columnId}=?',
      whereArgs: [taskStateId],
    );
    if(response.isEmpty) throw FormatException('No task\'s states found of: $taskStateId');

    return adaptMapToTaskState(response.first);
  }

  ///


  /// Task's Label

  @override
  Future<List<TaskLabel>> getTaskLabels() async {
    List<Map<String, dynamic>> labelsResponse = await _databaseManager.query(TaskLabelScheme.tableName,);
    if(labelsResponse.isEmpty) throw const FormatException('No task\'s labels found');

    return adaptMapListToTaskLabels(labelsResponse);
  }

  @override
  Future<TaskLabel?> getTaskLabel(int taskLabelId) async {
    final labelsResponse = await _databaseManager.query(
      TaskLabelScheme.tableName,
      where: '${TaskLabelScheme.columnId}=?',
      whereArgs: [taskLabelId],
    );
    if(labelsResponse.isEmpty) throw FormatException('No task\'s labels found of: $taskLabelId');

    return adaptMapToTaskLabel(labelsResponse.first);
  }

  ///


  /// Task

  @override
  Future<List<Task>> getTasks() async {
    final taskStates = await getTaskStates();
    final taskLabels = await getTaskLabels();
    List<Map<String, dynamic>> tasksResponse = await _databaseManager.query(TaskScheme.tableName,);

    return tasksResponse.map((taskMap) => adaptMapToTask(
      taskMap,
      taskStates.firstWhere((state) => taskMap[TaskScheme.columnStateId] == state.id),
      taskLabels.findItemBy<TaskLabel, int>(
        predicate: (label) => label.id,
        id: taskMap[TaskScheme.columnLabelId]
      ),
    )).toList();
  }

  @override
  Future<Task> createTask(CreateTask createTask) async {
    int id = await _databaseManager.insert(TaskScheme.tableName, adaptCreateTaskToMap(createTask));
    return await getTask(id);
  }

  @override
  Future<Task> getTask(id) async {
    final tasks = await _databaseManager.query(
      TaskScheme.tableName,
      where: '${TaskScheme.columnId}=?',
      whereArgs: [id],
      limit: 1,
    );
    final task = tasks.first;

    TaskLabel? taskLabel;
    if(task[TaskScheme.columnLabelId] != null) {
      taskLabel = await getTaskLabel(
          CoreUtils.parseObjectIntoInt(task[TaskScheme.columnLabelId])
      );
    }
    final taskState = await getTaskState(
        CoreUtils.parseObjectIntoInt(task[TaskScheme.columnStateId])
    );
    return adaptMapToTask(task, taskState, taskLabel);
  }

  @override
  Future<Task> updateTask(int id, CreateTask task) async {
    await _databaseManager.update(
      TaskScheme.tableName,
      adaptCreateTaskToMap(task),
      where: '${TaskScheme.columnId} = ?',
      whereArgs: [id],
    );
    return await getTask(id);
  }

  ///



  /// Task Time Log

  @override
  Future<List<TaskTimeLog>> getTaskTimeLogs(int taskId) async {
    final logs = await _databaseManager.query(
      TaskTimeLogScheme.tableName,
      where: '${TaskTimeLogScheme.columnTaskId}=?',
      whereArgs: [ taskId ],
    );
    if(logs.isEmpty) throw FormatException('No tasks time log found for task: $taskId');

    return adaptMapsToTasksTimeLog(logs);
  }

  @override
  Future<List<TaskTimeLog>> getTasksTimeLog() async {
    final logs = await _databaseManager.query(
      TaskTimeLogScheme.tableName,
    );
    return adaptMapsToTasksTimeLog(logs);
  }

  @override
  Future<TaskTimeLog> createTaskTimeLog(CreateTaskTimeLog log) async {
    int id = await _databaseManager.insert(
      TaskTimeLogScheme.tableName,
      adaptCreateTaskTimeLogToMap(log),
    );
    return await getTaskTimeLog(id);
  }

  @override
  Future<TaskTimeLog> getTaskTimeLog(int id) async {
    final logs = await _databaseManager.query(
      TaskTimeLogScheme.tableName,
      where: '${TaskTimeLogScheme.columnId}=?',
      whereArgs: [ id ],
    );
    if(logs.isEmpty) throw FormatException('No task\'s time log found with id:$id');

    return adaptMapToTaskTimeLog(logs.first);
  }

  @override
  Future<TaskTimeLog> stopTaskTimeLog(int taskId) async {
    List<TaskTimeLog> currentTaskTimers = await getTaskTimeLogs(taskId);
    List<TaskTimeLog> currentTaskPlayingTimeLogs = currentTaskTimers.playingLogs;
    if(currentTaskPlayingTimeLogs.isEmpty) throw FormatException('No playing task time log found for task: $taskId');

    await _databaseManager.update(
      TaskTimeLogScheme.tableName,
      adaptStopTaskTimeLogToMap(),
      where: '${TaskTimeLogScheme.columnId} = ?',
      whereArgs: [ currentTaskPlayingTimeLogs.first.id ],
    );
    return await getTaskTimeLog(currentTaskPlayingTimeLogs.first.id);
  }

  ///
}
