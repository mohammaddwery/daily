import '../task_state/task_state.dart';
import '../label/task_label.dart';

class Task {
  final int id;
  final String title;
  final String? description;
  final TaskLabel? label;
  final TaskState state;
  final DateTime createdAt;
  Task({
    required this.id,
    required this.title,
    this.description,
    this.label,
    required this.state,
    required this.createdAt,
  });
}