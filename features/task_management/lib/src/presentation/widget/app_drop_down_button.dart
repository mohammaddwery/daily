import 'package:core/core.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../localization/task_localization.dart';

class AppDropDownButton extends StatelessWidget {
  final List<String> options;
  final String hintKey;
  final BehaviorSubjectComponent<String?> selectedOptionController;
  const AppDropDownButton({
    required this.options,
    required this.hintKey,
    required this.selectedOptionController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: selectedOptionController.stream,
        builder: (context, selectedOptionSnapshot) {
          return Theme(
            data: ThemeData(useMaterial3: true),
            child: CustomDropdownButton2(
              buttonHeight: AppSizes.s52,
              hint: TaskLocalization.of(context).translate(hintKey),
              dropdownItems: options,
              value: selectedOptionSnapshot.data,
              onChanged: (value) =>
                selectedOptionController.setValue(value!),
            ),
          );
        }
    );
  }
}
