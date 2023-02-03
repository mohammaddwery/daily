import '../../data/model/task/create_task.dart';

class UpdateTaskUseCaseParam {
  final int id;
  final CreateTask task;
  UpdateTaskUseCaseParam({
    required this.id,
    required this.task,
  });
}