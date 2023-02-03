import 'package:task_management/src/data/model/task/create_task.dart';

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
  endDate: map['endDate'] == null ? null : DateTime.parse(map['endDate']).toLocal(),
  createdAt: DateTime.parse(map['createdAt']).toLocal(),
);

Map<String, dynamic> adaptCreateTaskToMap(CreateTask task) => {
  "title": task.title,
  "description": task.description,
  "labelId": task.labelId,
  "stateId": task.stateId,
};