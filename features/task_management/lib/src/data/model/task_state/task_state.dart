import '../task/task.dart';

class TaskState {
  final int id;
  final String name;
  List<Task> tasks;
  TaskState({
    required this.id,
    required this.name,
    this.tasks=const [],
  });
}