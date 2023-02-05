import 'package:core/core.dart';
import '../../../data/resource/local/task_database_provider.dart';
import '../../../data/model/task_time_log/task_time_log.dart';

class GetTasksTimeLogUseCase extends UseCase<List<TaskTimeLog>, NoParams> {
  final TaskDatabaseProvider _databaseProvider;
  GetTasksTimeLogUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<List<TaskTimeLog>> call(NoParams param) => _databaseProvider.getTasksTimeLog();
}