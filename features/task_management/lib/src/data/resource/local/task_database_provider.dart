import '../../model/task_time_log/create_task_time_log.dart';
import '../../model/task_time_log/task_time_log.dart';
import '../../model/label/task_label.dart';
import '../../model/task/create_task.dart';
import '../../model/task/task.dart';
import '../../model/task_state/task_state.dart';

abstract class TaskDatabaseProvider {
  Future<List<TaskState>> getTaskStatesWithTasks();
  Future<List<TaskState>> getTaskStates();
  Future<TaskState> getTaskState(int taskStateId);
  Future<List<Task>> getTasks();
  Future<Task> getTask(int id);
  Future<List<TaskLabel>> getTaskLabels();
  Future<TaskLabel?> getTaskLabel(int taskLabelId);
  Future<Task> createTask(CreateTask createTask);
  Future<Task> updateTask(int id, CreateTask task);
  Future<List<TaskTimeLog>> getTaskTimeLogs(int taskId);
  Future<List<TaskTimeLog>> getTasksTimeLog();
  Future<TaskTimeLog> getTaskTimeLog(int id);
  Future<TaskTimeLog> createTaskTimeLog(CreateTaskTimeLog log);
  Future<TaskTimeLog> stopTaskTimeLog(int taskId);
}