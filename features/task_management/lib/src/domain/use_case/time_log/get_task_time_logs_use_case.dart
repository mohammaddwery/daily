import 'package:core/core.dart';
import 'package:task_management/src/data/resource/local/task_database_provider.dart';
import 'package:task_management/src/data/model/task_time_log/task_time_log.dart';

class GetTaskTimeLogsUseCase extends UseCase<List<TaskTimeLog>, int> {
  final TaskDatabaseProvider _databaseProvider;
  GetTaskTimeLogsUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<List<TaskTimeLog>> call(int param) => _databaseProvider.getTaskTimeLogs(param);
}