import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/src/presentation/widget/task_base_widget_state.dart';
import 'package:task_management/src/presentation/widget/task_state/task_state_card.dart';
import '../../../data/model/task_state/task_state.dart';
import '../../helpers/task_subtitles_keys.dart';
import 'board_screen_bloc.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  TaskBaseWidgetState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends TaskBaseWidgetState<BoardScreen> {

  final bloc = AppInjector.I.get<BoardScreenBloc>();

  @override
  void initState() {
    bloc.fetchTaskStates();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildTaskStates(),
    );
  }

  PreferredSizeWidget buildAppbar() {
    return GeneralAppbar(
      appLocal.translate(TaskSubtitlesKeys.dailyBoard),
      hasBackButton: false,
    );
  }

  Widget buildTaskStates() {
    return ResultsListingPage<TaskState>(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      resultsStream: bloc.taskStatesController.stream,
      listItemBuilder: taskStatesItemBuilder,
      errorPlaceholderBuilder: (messageKey) => ErrorPlaceholderWidget(appLocal.translate(messageKey)),
      loadingWidget: const LoadingWidget(),
    );
  }

  Widget taskStatesItemBuilder(BuildContext context, int index, TaskState state) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.s16,
        bottom: AppSizes.s16,
        left: index == 0 ? AppSizes.s16 : 0,
        right: AppSizes.s16,
      ),
      child: Column(
        children: [
          TaskStateCard(
            state: state,
            cardWidth: width* .85,
            onTasksChanged: (task) => bloc.onTasksChanged(state.id, task),
          ),
        ],
      ),
    );
  }

}
