import 'dart:async';
import 'package:core/core.dart';
import 'package:navigator/navigator.dart';
import 'package:task_management/src/data/resource/local/app_task_database_provider.dart';
import 'package:task_management/src/domain/use_case/get_local_task_labels_use_case.dart';
import 'package:task_management/src/domain/use_case/get_local_task_states_use_case.dart';
import 'package:task_management/src/domain/use_case/update_task_locally_use_case.dart';
import 'package:task_management/src/presentation/screen/create_task/create_task_screen_bloc.dart';
import 'package:task_management/src/presentation/screen/upsert_task/upsert_task_screen_bloc.dart';
import 'package:task_management/src/presentation/widget/task_state/task_state_card.dart';
import '../data/model/label/task_label.dart';
import '../data/model/task/create_task.dart';
import '../data/model/task/task.dart';
import '../data/model/task_state/task_state.dart';
import '../data/resource/local/task_database_provider.dart';
import '../domain/use_case/create_task_locally_use_case.dart';
import '../domain/use_case/get_local_task_states_with_tasks_use_case.dart';
import '../domain/use_case/update_task_use_case_param.dart';
import '../presentation/router/app_task_navigator.dart';
import '../presentation/screen/board_screen/board_screen_bloc.dart';
import '../presentation/screen/update_task/update_task_screen_bloc.dart';
import '../presentation/widget/task_state/task_state_card_bloc.dart';


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
      ..registerFactory<GetLocalTaskStatesWithTasksUseCase>(() => GetLocalTaskStatesWithTasksUseCase(
        databaseProvider: injector.get(),
      ))
      ..registerFactory<UseCase<List<TaskLabel>, NoParams>>(() => GetLocalTaskLabelsUseCase(
        databaseProvider: injector.get(),
      ))
      ..registerFactory<UseCase<List<TaskState>, NoParams>>(() => GetLocalTaskStatesUseCase(
        databaseProvider: injector.get(),
      ))
      ..registerFactory<UseCase<Task, CreateTask>>(() => CreateTaskLocallyUseCase(
        databaseProvider: injector.get(),
      ))
      ..registerFactory<UseCase<Task, UpdateTaskUseCaseParam>>(() => UpdateTaskLocallyUseCase(
        databaseProvider: injector.get(),
      ))

    // PRESENTATION
      ..registerFactory<BoardScreenBloc>(() => BoardScreenBloc(
        getLocalTaskSatesUseCase: injector.get(),
      ))
      ..registerFactoryParam<TaskStateCardBloc>((tasks, _) => TaskStateCardBloc(
        taskNavigator: injector.get(),
        tasks: tasks,
      ))
      ..registerFactory<UpsertTaskScreenBloc>(() => CreateTaskScreenBloc(
        getLocalTaskStatesUseCase: injector.get(),
        getLocalTaskLabelsUseCase: injector.get(),
        createTaskLocallyUseCase: injector.get(),
      ))
      ..registerFactoryParam<UpdateTaskScreenBloc>((task, _) => UpdateTaskScreenBloc(
        getLocalTaskStatesUseCase: injector.get(),
        getLocalTaskLabelsUseCase: injector.get(),
        updateTaskLocallyUseCase: injector.get(),
        task: task,
      ))
      ..registerFactory<TaskNavigator>(() => AppTaskNavigator())
    ;
  }
}
