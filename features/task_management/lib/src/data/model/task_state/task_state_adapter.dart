import 'package:core/core.dart';

import 'task_state.dart';

List<TaskState> adaptMapListToTaskStates(List<Map<String, dynamic>> maps,)
=> List<TaskState>.from(maps.map((e) => adaptMapToTaskState(e)));

TaskState adaptMapToTaskState(Map<String, dynamic> stateMap,) => TaskState(
  id: stateMap['id'],
  name: stateMap['name'],
);
