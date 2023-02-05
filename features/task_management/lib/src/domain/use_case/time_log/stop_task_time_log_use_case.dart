import 'package:core/core.dart';
import '../../../data/resource/local/task_database_provider.dart';
import '../../../data/model/task_time_log/task_time_log.dart';

class StopTaskTimeLogUseCase extends UseCase<TaskTimeLog, int> {
  final TaskDatabaseProvider _databaseProvider;
  StopTaskTimeLogUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<TaskTimeLog> call(int param) => _databaseProvider.stopTaskTimeLog(param);

}