import 'package:core/core.dart';
import '../../data/model/task/task.dart';
import '../../data/resource/local/task_database_provider.dart';
import 'update_task_use_case_param.dart';

class UpdateTaskLocallyUseCase extends UseCase<Task, UpdateTaskUseCaseParam> {
  final TaskDatabaseProvider _databaseProvider;
  UpdateTaskLocallyUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<Task> call(UpdateTaskUseCaseParam param) => _databaseProvider.updateTask(
    param.id,
    param.task,
  );
}