import 'package:core/core.dart';
import '../../../data/model/task_time_log/task_time_log.dart';
import '../../../data/model/task_time_log/create_task_time_log.dart';
import '../../../data/resource/local/task_database_provider.dart';

class CreateTaskTimeLogUseCase extends UseCase<TaskTimeLog, int> {
  final TaskDatabaseProvider _databaseProvider;
  CreateTaskTimeLogUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<TaskTimeLog> call(int param) => _databaseProvider.createTaskTimeLog(CreateTaskTimeLog(
    taskId: param,
    start: DateTime.now(),
  ));
}