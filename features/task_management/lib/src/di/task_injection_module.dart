import 'dart:async';
import 'package:core/core.dart';
import 'package:navigator/navigator.dart';
import 'package:task_management/src/data/resource/local/app_task_database_provider.dart';
import '../data/model/task_state/task_state.dart';
import '../data/resource/local/task_database_provider.dart';
import '../domain/use_case/get_local_task_states_use_case.dart';
import '../presentation/router/app_task_navigator.dart';
import '../presentation/screen/board_screen/board_screen_bloc.dart';


class TaskInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector
    // DATA
      ..registerFactory<TaskDatabaseProvider>(() => AppTaskDatabaseProvider(
        databaseManager: injector.get(),
      ))
    // DOMAIN
      ..registerFactory<UseCase<List<TaskState>, NoParams>>(() => GetLocalTaskSatesUseCase(
        databaseProvider: injector.get(),
      ))

    // PRESENTATION
      ..registerFactory<BoardScreenBloc>(() => BoardScreenBloc(
        getLocalTaskSatesUseCase: injector.get(),
      ))
      ..registerFactory<TaskNavigator>(() => AppTaskNavigator())
    ;
  }
}
