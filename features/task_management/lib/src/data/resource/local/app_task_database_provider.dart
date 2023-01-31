import 'package:core/core.dart';
import '../../model/label/task_label.dart';
import '../../model/task/task.dart';
import '../../model/task/task_adapter.dart';
import '../../model/task_state/task_state_adapter.dart';
import '../../model/label/task_label_adapter.dart';
import '../../model/task_state/task_state.dart';
import 'task_database_provider.dart';

class AppTaskDatabaseProvider extends TaskDatabaseProvider {
  final DatabaseManager _databaseManager;
  AppTaskDatabaseProvider({
    required DatabaseManager databaseManager,
  }): _databaseManager = databaseManager;

  @override
  Future<List<TaskState>> getTaskStatesWithTasks() async {
    final taskStates = await getTaskStates();
    final tasks = await getTasks();

    return taskStates.map((state) => TaskState(
      id: state.id,
      name: state.name,
      tasks: tasks.where((tasks) => tasks.state.id == state.id).toList(),
    )).toList();
  }

  @override
  Future<List<TaskLabel>> getTaskLabels() async {
    List<Map<String, dynamic>> labelsResponse = await _databaseManager.query(TaskLabelScheme.tableName,);
    return adaptMapListToTaskLabels(labelsResponse);
  }

  @override
  Future<List<TaskState>> getTaskStates() async {
    List<Map<String, dynamic>> statesResponse = await _databaseManager.query(TaskStateScheme.tableName,);
    return adaptMapListToTaskStates(statesResponse);
  }

  @override
  Future<List<Task>> getTasks() async {
    final taskStates = await getTaskStates();
    final taskLabels = await getTaskLabels();
    List<Map<String, dynamic>> tasksResponse = await _databaseManager.query(TaskScheme.tableName,);

    return tasksResponse.map((taskMap) => adaptMapToTask(
      taskMap,
      taskStates.firstWhere((state) => taskMap[TaskScheme.columnStateId] == state.id),
      taskLabels.firstWhere((label) => taskMap[TaskScheme.columnLabelId] == label.id),
    )).toList();
  }
}