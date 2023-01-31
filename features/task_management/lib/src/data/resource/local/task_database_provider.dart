import '../../model/label/task_label.dart';
import '../../model/task/task.dart';
import '../../model/task_state/task_state.dart';

abstract class TaskDatabaseProvider {
  Future<List<TaskState>> getTaskStatesWithTasks();
  Future<List<TaskState>> getTaskStates();
  Future<List<Task>> getTasks();
  Future<List<TaskLabel>> getTaskLabels();
}