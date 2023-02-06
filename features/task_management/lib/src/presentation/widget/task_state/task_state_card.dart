import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../core/task_constants.dart';
import '../../helpers/task_icons.dart';
import '../task_base_widget_state.dart';
import '../../../data/model/task_state/task_state.dart';
import '../../helpers/task_subtitles_keys.dart';
import '../../widget/task_card/task_card.dart';
import '../../../data/model/task/task.dart';
import 'task_state_card_bloc.dart';


class TaskStateCard extends StatefulWidget {
  final TaskState state;
  final double? cardWidth;
  /// Called ONLY when user moved or create the task in another state.
  final Function(Task task) onTasksChanged;
  const TaskStateCard({
    required this.state,
    this.cardWidth,
    required this.onTasksChanged,
    Key? key,
  }) : super(key: key);

  @override
  TaskBaseWidgetState<TaskStateCard> createState() => _TaskStateCardState();
}

class _TaskStateCardState extends TaskBaseWidgetState<TaskStateCard> {

  late TaskStateCardBloc bloc;

  @override
  void initState() {
    bloc = AppInjector.I.get<TaskStateCardBloc>(param1: widget.state);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return AppCard(
      color: Theme.of(context).colorScheme.secondaryCardBackground,
      padding: const EdgeInsets.only(
        top: AppSizes.s24,
        bottom: AppSizes.s8,
        right: AppSizes.s8,
        left: AppSizes.s8,
      ),
      width: widget.cardWidth,
      child: Column(
        children: [
          buildTitle(),
          const SizedBox(height: AppSizes.s8,),
          buildTasks(),
          buildCreateTaskButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.state.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: AppFonts.semiBold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        ImageButtonWidget(
          packageName: TaskConstants.packageName,
          imageUrl: TaskIcons.exportCsv,
          color: Theme.of(context).colorScheme.greyShade700,
          onClicked: () => bloc.onExportCsvClicked(),
          width: AppSizes.s20,
          height: AppSizes.s20,
        ),
      ],
    );
  }

  Widget buildTasks() {
    return StreamBuilder<List<Task>>(
      initialData: const [],
      stream: bloc.tasksController.stream,
      builder: (context, tasksSnapshot) {
        if(tasksSnapshot.data!.isEmpty) return const SizedBox(height: AppSizes.s32,);

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: height* .65,
            minHeight: AppSizes.s90,
            minWidth: double.infinity,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: tasksSnapshot.data!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: AppSizes.s8,),
              child: TaskCard(
                task: tasksSnapshot.data![index],
                onUpdateTaskClicked: (task) => bloc.onUpdateTaskClicked(
                  context: context,
                  task: task,
                  onDoneCallback: (task) => widget.onTasksChanged(task),
                ),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(height: index == tasksSnapshot.data!.length-1 ? AppSizes.s8 : AppSizes.s4,),
          ),
        );
      }
    );
  }

  Widget buildCreateTaskButton() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.s8,),
      child: AppTextButton(
        onClicked: () => bloc.onCreateTaskClicked(
          context: context,
          state: widget.state,
          onDoneCallback: (task) => widget.onTasksChanged(task),
        ),
        color: Theme.of(context).primaryColor,
        title: appLocal.translate(TaskSubtitlesKeys.newTask),
        icon: AppIcons.plus,
        packageName: CoreConstants.packageName,
      ),
    );
  }
}
