import 'dart:async';
import 'package:core/core.dart';
import 'package:navigator/navigator.dart';
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

    // DOMAIN


    // PRESENTATION

      ..registerFactory<BoardScreenBloc>(() => BoardScreenBloc())
      ..registerFactory<TaskNavigator>(() => AppTaskNavigator())
    ;
  }
}
