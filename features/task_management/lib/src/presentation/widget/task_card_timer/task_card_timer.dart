import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../task_base_widget_state.dart';
import 'task_timer.dart';
import 'task_timer_bloc.dart';

class TaskCardTimer extends StatefulWidget {
  final int taskId;
  const TaskCardTimer(this.taskId, {Key? key}) : super(key: key);

  @override
  TaskBaseWidgetState<TaskCardTimer> createState() => _TaskCardTimerState();
}

class _TaskCardTimerState extends TaskBaseWidgetState<TaskCardTimer> {

  late TaskCardTimerBloc taskTimerBloc;

  @override
  void initState() {
    taskTimerBloc = AppInjector.I.get<TaskCardTimerBloc>(param1: widget.taskId);
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return StreamBuilder<TaskTimer?>(
        stream: taskTimerBloc.currentTaskTimerController.stream,
        builder: (context, taskTimerSnapshot) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTimerLabel(taskTimerSnapshot.data),
              buildActionButton(taskTimerSnapshot.data),
            ],
          );
        }
    );
  }

  Widget buildTimerLabel(TaskTimer? taskTimer) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        border: Border.all(
          width: .75,
          color: Theme.of(context).primaryColor,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.s4, horizontal: AppSizes.s8),
      child: Text(
        taskTimer?.formatDuration??'00:00:00',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.greyShade900,
        ),
      ),
    );
  }

  Widget buildActionButton(TaskTimer? taskTimer) {
    return InkWell(
      onTap: taskTimerBloc.switchTimerState,
      radius: AppSizes.s32,
      borderRadius: BorderRadius.circular(AppSizes.s32),
      splashColor: Theme.of(context).primaryColor.withOpacity(.35),
      focusColor: Theme.of(context).primaryColor.withOpacity(.65),
      highlightColor: Theme.of(context).primaryColor.withOpacity(.35),
      hoverColor: Colors.white.withOpacity(.25),
      child: AnimatedCrossFade(
        firstChild: _buildImageWidget(Icons.play_arrow_rounded),
        secondChild: _buildImageWidget(Icons.pause_rounded),
        crossFadeState: (taskTimer?.playing??false) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  _buildImageWidget(IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).primaryColor,
      size: AppSizes.s32,
    );
  }

}
