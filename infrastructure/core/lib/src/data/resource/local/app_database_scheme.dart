
class TaskStateScheme {
  static const String tableName = 'task_state';
  static const String columnId = 'id';
  static const String columnName = 'name';
}
class TaskLabelScheme {
  static const String tableName = 'task_label';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnColor = 'color';
}
class TaskScheme {
  static const String tableName = 'task';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnDescription = 'description';
  static const String columnLabelId = 'labelId';
  static const String columnStateId = 'stateId';
  static const String columnCreatedAt = 'createdAt';
}
class TaskTimeLogScheme {
  static const String tableName = 'task_time_log';
  static const String columnId = 'id';
  static const String columnStart = 'start';
  static const String columnEnd = 'end';
  static const String columnTaskId = 'taskId';
}