import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/src/data/model/task/task.dart';
import 'package:task_management/src/presentation/screen/update_task/update_task_screen_bloc.dart';
import '../../helpers/task_subtitles_keys.dart';
import '../../widget/task_base_widget_state.dart';
import '../upsert_task/upsert_task_screen.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;
  const UpdateTaskScreen(this.task, {Key? key}) : super(key: key);

  @override
  TaskBaseWidgetState<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends TaskBaseWidgetState<UpdateTaskScreen> {
  late UpdateTaskScreenBloc bloc;

  @override
  void initState() {
    bloc = AppInjector.I.get<UpdateTaskScreenBloc>(param1: widget.task,);
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return UpsertTaskScreen(
      titleKey: TaskSubtitlesKeys.updateTask,
      bloc: bloc,
    );
  }
}
