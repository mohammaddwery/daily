import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/task/task.dart';
import 'task_label_badge.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: double.infinity,
      height: AppSizes.s110,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.s16, horizontal: AppSizes.s16,),
      shadow: BoxShadow(color: Colors.black.withOpacity(0.0),),
      onClicked: () {}, // TODO: Implement onClicked
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTaskTitle(context),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildLabel(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTaskTitle(BuildContext context) {
    return Text(
      task.title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        height: 1.1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildLabel() {
    if(task.label==null) return const SizedBox();

    return TaskLabelBadge(task.label!);
  }
}
