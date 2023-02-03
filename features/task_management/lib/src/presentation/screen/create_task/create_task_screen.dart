import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task_state/task_state.dart';
import '../upsert_task/upsert_task_screen.dart';
import '../upsert_task/upsert_task_screen_bloc.dart';
import '../../widget/task_base_widget_state.dart';
import '../../helpers/task_subtitles_keys.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  TaskBaseWidgetState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends TaskBaseWidgetState<CreateTaskScreen> {

  final bloc = AppInjector.I.get<UpsertTaskScreenBloc>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(onWidgetStarted);
    super.initState();
  }

  onWidgetStarted(timeStamp) {
    TaskState state = ModalRoute.of(context)!.settings.arguments as TaskState;
    bloc.selectedTaskStateController.setValue(state.name);
  }

  @override
  Widget buildContent(BuildContext context) {
    return UpsertTaskScreen(
      titleKey: TaskSubtitlesKeys.createTask,
      bloc: bloc,
    );
  }
}
