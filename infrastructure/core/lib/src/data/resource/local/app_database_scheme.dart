
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
  static const String columnEndDate = 'endDate';
  static const String columnCreatedAt = 'createdAt';
}