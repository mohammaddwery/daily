import 'package:core/core.dart';
import 'package:task_management/src/data/model/label/task_label.dart';
import '../../data/resource/local/task_database_provider.dart';
import '../../data/model/task_state/task_state.dart';

class GetLocalTaskLabelsUseCase extends UseCase<List<TaskLabel>, NoParams> {
  final TaskDatabaseProvider _databaseProvider;
  GetLocalTaskLabelsUseCase({
    required TaskDatabaseProvider databaseProvider,
  }): _databaseProvider = databaseProvider;

  @override
  Future<List<TaskLabel>> call(NoParams param) => _databaseProvider.getTaskLabels();
}