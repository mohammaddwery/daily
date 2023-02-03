import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/label/task_label.dart';
import '../../../data/model/task/create_task.dart';
import '../../../data/model/task_state/task_state.dart';
import '../../helpers/task_subtitles_keys.dart';
import '../../localization/task_localization.dart';

abstract class UpsertTaskScreenBloc extends CrudDataBlocHandler {
  final UseCase<List<TaskState>, NoParams> _getLocalTaskStatesUseCase;
  final UseCase<List<TaskLabel>, NoParams> _getLocalTaskLabelsUseCase;
  UpsertTaskScreenBloc({
    required UseCase<List<TaskState>, NoParams> getLocalTaskStatesUseCase,
    required UseCase<List<TaskLabel>, NoParams> getLocalTaskLabelsUseCase,
  }): _getLocalTaskStatesUseCase = getLocalTaskStatesUseCase,
        _getLocalTaskLabelsUseCase = getLocalTaskLabelsUseCase {
    fetchTaskStates();
    fetchTaskLabels();
  }

  final loadingController = SeededBehaviorSubjectComponent<bool>(false);
  final selectedTaskLabelController = BehaviorSubjectComponent<String?>();
  final selectedTaskStateController = BehaviorSubjectComponent<String?>();
  final taskStatesController = BehaviorSubjectComponent<UiState<List<TaskState>>?>();
  final taskLabelsController = BehaviorSubjectComponent<UiState<List<TaskLabel>>?>();
  final taskTitleTextEditingController = TextEditingController();
  final taskDescriptionTextEditingController = TextEditingController();

  fetchTaskStates() => handleCrudDataList<TaskState>(
    getCurrentState: taskStatesController.getValue,
    setCurrentState: taskStatesController.setValue,
    exceptionTag: 'UpsertTaskScreenBloc fetchTaskStates()',
    crudDataList: () async => _getLocalTaskStatesUseCase.call(NoParams()),
  );

  fetchTaskLabels() => handleCrudDataList<TaskLabel>(
    getCurrentState: taskLabelsController.getValue,
    setCurrentState: taskLabelsController.setValue,
    exceptionTag: 'UpsertTaskScreenBloc fetchTaskLabels()',
    crudDataList: () async => _getLocalTaskLabelsUseCase.call(NoParams()),
  );


  String? _validateInputFields() {
    if(selectedTaskStateController.getValue() == null) {
      return TaskSubtitlesKeys.selectTaskStateValidationMessage;
    }

    if(taskTitleTextEditingController.text.isNullOrEmpty
        || taskTitleTextEditingController.text.length > 100) {
      return TaskSubtitlesKeys.taskTitleValidationMessage;
    }

    if(taskDescriptionTextEditingController.text.length > 500) {
      return TaskSubtitlesKeys.taskDescriptionValidationMessage;
    }

    return null;
  }


  void onUpsertTaskClicked(BuildContext context) {
    loadingController.setValue(true);
    String? validationMessage = _validateInputFields();
    if(validationMessage!=null) {
      onUpsertTaskFailed(TaskLocalization.of(context).translate(validationMessage));
      return;
    }

    upsertTask(context);
  }

  upsertTask(BuildContext context);

  CreateTask get createTask => CreateTask(
    title: taskTitleTextEditingController.text.trim(),
    description: taskDescriptionTextEditingController.text.trim(),
    stateId: _createTaskState,
    labelId: _createTaskLabel,
  );

  int get _createTaskState => taskStatesController.getValue()!.data!.findItemBy<TaskState, String>(
    predicate: (state) => state.name,
    id: selectedTaskStateController.getValue(),
  )!.id;

  int? get _createTaskLabel => taskLabelsController.getValue()?.data?.findItemBy<TaskLabel, String>(
    predicate: (label) => label.name,
    id: selectedTaskLabelController.getValue(),
  )?.id;

  onUpsertTaskSucceed<T>(BuildContext context, T task) {
    loadingController.setValue(false);
    Navigator.of(context).pop(task);
  }

  onUpsertTaskFailed(String message) {
    loadingController.setValue(false);
    ToastHelper.showToast(message);
  }

  @override
  void dispose() {
    loadingController.dispose();
    selectedTaskLabelController.dispose();
    selectedTaskStateController.dispose();
    taskStatesController.dispose();
    taskLabelsController.dispose();
    taskTitleTextEditingController.dispose();
    taskDescriptionTextEditingController.dispose();
  }
}