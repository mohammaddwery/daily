import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task/task.dart';
import '../../../data/model/task_state/task_state.dart';
import '../../../domain/use_case/get_local_task_states_with_tasks_use_case.dart';


class BoardScreenBloc extends CrudDataBlocHandler {
  final GetLocalTaskStatesWithTasksUseCase _getLocalTaskSatesWithTasksUseCase;
  BoardScreenBloc({
    required GetLocalTaskStatesWithTasksUseCase getLocalTaskSatesUseCase,
  }): _getLocalTaskSatesWithTasksUseCase = getLocalTaskSatesUseCase;

  final taskStatesController = BehaviorSubjectComponent<UiState<List<TaskState>>?>();
  int get taskStatesCount => taskStatesController.getValue()?.data?.length??0;

  static const String logTag = 'BoardScreenBloc';

  fetchTaskStates() async => handleCrudDataList(
    getCurrentState: taskStatesController.getValue,
    setCurrentState: taskStatesController.setValue,
    exceptionTag: '$logTag fetchTaskStates()',
    crudDataList: () async => await _getLocalTaskSatesWithTasksUseCase.call(NoParams()),
  );

  void onTasksChanged(int oldStateId, Task task) {
    List<TaskState> states = List.of(taskStatesController.getValue()!.data!);
    TaskState state = states.findItemBy<TaskState, int>(
      predicate: (state) => state.id,
      id: task.state.id,
    )!;

    /// remove task from the old state cause the task created or moved to another state
    TaskState oldState = states.findItemBy<TaskState, int>(
      predicate: (state) => state.id,
      id: oldStateId,
    )!;
    oldState.tasks.removeWhere((element) => element.id == task.id);

    state.tasks.add(task);
    taskStatesController.setValue(UiState.success(states));
  }

  @override
  void dispose() {
    taskStatesController.dispose();
  }
}