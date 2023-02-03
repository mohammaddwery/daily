import 'package:core/core.dart';
import '../../data/model/task/create_task.dart';
import '../../data/model/task/task.dart';
import '../../data/resource/local/task_database_provider.dart';

class CreateTaskLocallyUseCase extends UseCase<Task, CreateTask> {
  final TaskDatabaseProvider _databaseProvider;
  CreateTaskLocallyUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<Task> call(CreateTask param) => _databaseProvider.createTask(param);
}