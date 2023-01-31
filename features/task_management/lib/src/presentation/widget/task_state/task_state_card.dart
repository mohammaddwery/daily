import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/src/presentation/widget/task_base_widget_state.dart';
import '../../../data/model/task_state/task_state.dart';
import '../../helpers/task_subtitles_keys.dart';
import '../../widget/task_card/task_card.dart';
import '../../../data/model/task/task.dart';

class TaskStateCard extends StatefulWidget {
  final TaskState state;
  final double? cardWidth;
  const TaskStateCard(this.state,
      {this.cardWidth,
    Key? key,
  }) : super(key: key);

  @override
  TaskBaseWidgetState<TaskStateCard> createState() => _TaskStateCardState();
}

class _TaskStateCardState extends TaskBaseWidgetState<TaskStateCard> {
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
          buildTasks(widget.state.tasks),
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
      ],
    );
  }

  Widget buildTasks(List<Task> tasks) {
    if(tasks.isEmpty) return const SizedBox(height: AppSizes.s32,);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height* .66,
        minHeight: AppSizes.s90,
        minWidth: double.infinity,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: tasks.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: AppSizes.s8,),
          child: TaskCard(task: tasks[index]),
        ),
        separatorBuilder: (context, index) => SizedBox(height: index == tasks.length-1 ? AppSizes.s8 : AppSizes.s4,),
      ),
    );
  }

  Widget buildCreateTaskButton() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.s8,),
      child: AppTextButton(
        onClicked: () {}, //TODO: Implement onCreateTaskClicked
        color: Theme.of(context).primaryColor,
        title: appLocal.translate(TaskSubtitlesKeys.newTask),
        icon: AppIcons.plus,
        packageName: CoreConstants.packageName,
      ),
    );
  }
}
