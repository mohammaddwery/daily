import 'package:core/src/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import '../styles/app_sizes.dart';

class AppTextField extends StatefulWidget {
  final EdgeInsets contentPadding;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final int maxLines;
  final String? initialValue;
  final TextInputAction textInputAction;

  const AppTextField({
    Key? key,
    required this.hint,
    this.initialValue,
    this.contentPadding=const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    this.textInputType=TextInputType.text,
    this.textInputAction=TextInputAction.next,
    this.onChanged,
    this.controller,
    this.validator,
    this.maxLines = 1,
  }) : super(key: key);


  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  @override
  void initState() {
    if(widget.initialValue != null){
     if(widget.onChanged != null) widget.onChanged!(widget.initialValue!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      textInputAction: widget.textInputAction,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      onChanged: (value) {
        if(widget.onChanged!=null) widget.onChanged!(value.trim());
      },
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade900,
      ),
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: widget.contentPadding,
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade500,
          height: 1.4,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
          borderSide:  BorderSide(
            color: Theme.of(context).colorScheme.greyShade900,
            width: .5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: .5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
          borderSide:  BorderSide(
            color: Theme.of(context).colorScheme.greyShade900,
            width: .5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: .75,
          ),
        ),
      ),
    );
  }
}
