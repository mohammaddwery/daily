import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/src/data/model/task_state/task_state.dart';
import 'package:task_management/src/presentation/helpers/task_subtitles_keys.dart';
import 'package:task_management/src/presentation/widget/app_drop_down_button.dart';
import '../../../data/model/label/task_label.dart';
import '../../widget/task_base_widget_state.dart';
import 'upsert_task_screen_bloc.dart';

class UpsertTaskScreen extends StatefulWidget {
  final String titleKey;
  final UpsertTaskScreenBloc bloc;
  final List<Widget> appbarActions;
  const UpsertTaskScreen({
    required this.titleKey,
    required this.bloc,
    this.appbarActions=const[],
    Key? key,
  }) : super(key: key);

  @override
  TaskBaseWidgetState<UpsertTaskScreen> createState() => _UpsertTaskScreenState();
}

class _UpsertTaskScreenState extends TaskBaseWidgetState<UpsertTaskScreen> {

  late UpsertTaskScreenBloc bloc;

  @override
  void initState() {
    bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16,),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.s24,),
                  buildTaskStateComponent(),
                  const SizedBox(height: AppSizes.s24,),
                  buildTaskTitleComponent(),
                  const SizedBox(height: AppSizes.s24,),
                  buildTaskDescriptionComponent(),
                  const SizedBox(height: AppSizes.s24,),
                  buildTaskLabelComponent(),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.s90,),
                  const Spacer(),
                  buildUpsertTaskButton(),
                  const SizedBox(height: AppSizes.s32,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GeneralAppbar buildAppbar() {
    return GeneralAppbar(
      appLocal.translate(widget.titleKey),
    );
  }

  Widget buildTaskStateComponent() {
    return Row(
      children: [
        _buildComponentTitle(TaskSubtitlesKeys.status),
        const SizedBox(width: AppSizes.s80,),
        buildTaskStateSelector(),
      ],
    );
  }

  Widget buildTaskStateSelector() {
    return Expanded(
      child: StreamBuilder<UiState<List<TaskState>>?>(
          stream: bloc.taskStatesController.stream,
          builder: (context, statesSnapshot) {
            switch (statesSnapshot.data?.status) {
              case UiStateStatus.loading:
                return const LoadingWidget();
              case UiStateStatus.success:
                return AppDropDownButton(
                  hintKey: TaskSubtitlesKeys.selectYourState,
                  selectedOptionController: bloc.selectedTaskStateController,
                  options: statesSnapshot.data!.data!.map((state) => state.name).toList(),
                );
              case UiStateStatus.failure:
                return ErrorPlaceholderWidget(statesSnapshot.data!.message!,);

              default:
                return const SizedBox();
            }
          }
      ),
    );
  }

  Widget buildTaskTitleComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentTitle(TaskSubtitlesKeys.title),
        const SizedBox(height: AppSizes.s8),
        AppTextField(
          controller: bloc.taskTitleTextEditingController,
          hint: appLocal.translate(TaskSubtitlesKeys.typeYourTaskTitle),
        ),
      ],
    );
  }

  Widget buildTaskDescriptionComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentTitle(TaskSubtitlesKeys.description),
        const SizedBox(height: AppSizes.s8),
        AppTextField(
          controller: bloc.taskDescriptionTextEditingController,
          hint: appLocal.translate(TaskSubtitlesKeys.typeYourTaskDescription),
          maxLines: 6,
          textInputType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
        ),
      ],
    );
  }

  Widget buildTaskLabelComponent() {
    return Row(
      children: [
        _buildComponentTitle(TaskSubtitlesKeys.label),
        const SizedBox(width: AppSizes.s80,),
        buildTaskLabelSelector(),
      ],
    );
  }

  Widget buildTaskLabelSelector() {
    return Expanded(
      child: StreamBuilder<UiState<List<TaskLabel>>?>(
          stream: bloc.taskLabelsController.stream,
          builder: (context, labelsSnapshot) {
            switch (labelsSnapshot.data?.status) {
              case UiStateStatus.loading:
                return const LoadingWidget();
              case UiStateStatus.success:
                return AppDropDownButton(
                  hintKey: TaskSubtitlesKeys.selectYourLabel,
                  selectedOptionController: bloc.selectedTaskLabelController,
                  options: labelsSnapshot.data!.data!.map((label) => label.name).toList(),
                );
              case UiStateStatus.failure:
                return ErrorPlaceholderWidget(labelsSnapshot.data!.message!,);

              default:
                return const SizedBox();
            }
          }
      ),
    );
  }

  Widget buildUpsertTaskButton() {
    return AppButton(
      title: appLocal.translate(widget.titleKey),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.s16,),
      onClicked: () => bloc.onUpsertTaskClicked(context),
      loadingStream: bloc.loadingController.stream,
    );
  }

  _buildComponentTitle(String titleKey) {
    return Text(
      appLocal.translate(titleKey),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: AppFonts.medium,
      ),
    );
  }
}
