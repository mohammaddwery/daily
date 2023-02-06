import '../task/create_task.dart';
import '../label/task_label.dart';
import '../task_state/task_state.dart';
import 'task.dart';

List<Task> adaptMapListToTasks(List<Map<String, dynamic>> maps, TaskState state, TaskLabel label,)
=> List<Task>.from(maps.map((e) => adaptMapToTask(e, state, label)));

Task adaptMapToTask(Map<String, dynamic> map, TaskState state, TaskLabel? label,) => Task(
  id: map['id'],
  title: map['title'],
  description: map['description'],
  label: label,
  state: state,
  createdAt: DateTime.parse(map['createdAt']).toLocal(),
);

Map<String, dynamic> adaptCreateTaskToMap(CreateTask task) => {
  "title": task.title,
  "description": task.description,
  "labelId": task.labelId,
  "stateId": task.stateId,
};

List<List<dynamic>> adaptTasksToCsvEntries(List<Task> tasks) => tasks.map((e) => [
  e.id,
  e.title,
  e.description,
  e.label?.name,
  e.state.name,
  e.createdAt.toIso8601String(),
]).toList();