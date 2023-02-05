import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/src/core/task_constants.dart';
import '../../../core/enum.dart';
import '../../../data/model/task/task.dart';
import '../task_card_timer/task_timer_bloc.dart';
import '../task_card_timer/task_card_timer.dart';
import 'task_label_badge.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task task) onUpdateTaskClicked;
  const TaskCard({
    required this.task,
    required this.onUpdateTaskClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: double.infinity,
      height: AppSizes.s110,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.s16, horizontal: AppSizes.s16,),
      shadow: BoxShadow(color: Colors.black.withOpacity(0.0),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTaskTitle(context),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTaskTimer(),
              const Spacer(),
              buildLabel(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTaskTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            task.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        ImageButtonWidget(
          packageName: CoreConstants.packageName,
          imageUrl: AppIcons.edit,
          color: Theme.of(context).colorScheme.greyShade700,
          onClicked: () => onUpdateTaskClicked(task),
          width: AppSizes.s20,
          height: AppSizes.s20,
        ),
      ],
    );
  }

  Widget buildTaskTimer() {
    if(task.state.name != adaptEnumToString(TaskState.INGROGRESS)) {
      return const SizedBox();
    }

    return TaskCardTimer(key: Key('${task.id}'), task.id);
  }

  Widget buildLabel() {
    if(task.label==null) return const SizedBox();

    return TaskLabelBadge(task.label!);
  }
}
