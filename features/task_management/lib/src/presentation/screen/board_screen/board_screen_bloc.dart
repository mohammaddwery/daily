import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task/task.dart';
import '../../../data/model/label/task_label.dart';
import '../../../data/model/task_state/task_state.dart';


class BoardScreenBloc extends CrudDataBlocHandler {
  final UseCase<List<TaskState>, NoParams> _getLocalTaskSatesUseCase;
  BoardScreenBloc({
    required UseCase<List<TaskState>, NoParams> getLocalTaskSatesUseCase,
  }): _getLocalTaskSatesUseCase = getLocalTaskSatesUseCase;

  final taskStatesController = BehaviorSubjectComponent<UiState<List<TaskState>>?>();
  int get taskStatesCount => taskStatesController.getValue()?.data?.length??0;

  static const String logTag = 'BoardScreenBloc';

  fetchTaskState() async => handleCrudDataList(
    getCurrentState: taskStatesController.getValue,
    setCurrentState: taskStatesController.setValue,
    exceptionTag: '$logTag fetchTaskState()',
    crudDataList: () async => await _getLocalTaskSatesUseCase.call(NoParams()),
  );

  final List<TaskState> _taskStates = [
    TaskState(
      id: 1,
      name: 'TODO',
      tasks: [
        Task(
          id: 1,
          title: 'Design Home',
          description: 'description',
          state: TaskState(id: 1, name: 'TODO'),
          createdAt: DateTime.now(),
          label: TaskLabel(id: 1, name: 'UI', color: Colors.greenAccent),
        ),
      ],
    ),
    TaskState(
      id: 2,
      name: 'INPROGRESS',
      tasks: [
        Task(
          id: 2,
          title: 'Test timer',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          label: TaskLabel(id: 1, name: 'WEB', color: Colors.lightBlueAccent),
        ),
        Task(
          id: 3,
          title: 'Implement login',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          label: TaskLabel(id: 1, name: 'MOBILE', color: Colors.orangeAccent),
        ),

        Task(
          id: 2,
          title: 'Test timer',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Task(
          id: 3,
          title: 'As a user I need to authenticate via social networks.',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),

        Task(
          id: 2,
          title: 'Test timer',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Task(
          id: 3,
          title: 'Implement login',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),

        Task(
          id: 2,
          title: 'Test timer',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Task(
          id: 3,
          title: 'Implement login',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),

        Task(
          id: 2,
          title: 'Test timer',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Task(
          id: 3,
          title: 'Implement login',
          description: 'description',
          state: TaskState(id: 2, name: 'INPROGRESS'),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ],
    ),
    TaskState(
      id: 3,
      name: 'DONE',
    ),
  ];

  @override
  void dispose() {
    taskStatesController.dispose();
  }
}