class CreateTask {
  final String title;
  final String? description;
  final int? labelId;
  final int stateId;
  CreateTask({
    required this.title,
    this.description,
    this.labelId,
    required this.stateId,
  });
}