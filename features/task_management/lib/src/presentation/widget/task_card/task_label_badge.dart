import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../data/model/label/task_label.dart';

class TaskLabelBadge extends StatelessWidget {
  final TaskLabel label;
  const TaskLabelBadge(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.s4, horizontal: AppSizes.s8,),
      decoration: BoxDecoration(
        color: label.color.withOpacity(.15),
        borderRadius: BorderRadius.circular(AppSizes.s4),
      ),
      child: Text(
        label.name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: label.color,
          fontWeight: AppFonts.medium,
        ),
      ),
    );
  }
}
