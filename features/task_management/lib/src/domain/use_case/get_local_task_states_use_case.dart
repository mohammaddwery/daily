import 'package:core/core.dart';
import '../../data/resource/local/task_database_provider.dart';
import '../../data/model/task_state/task_state.dart';

class GetLocalTaskSatesUseCase extends UseCase<List<TaskState>, NoParams> {
  final TaskDatabaseProvider _databaseProvider;
  GetLocalTaskSatesUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<List<TaskState>> call(NoParams param) => _databaseProvider.getTaskStatesWithTasks();
}