import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../styles/app_sizes.dart';
import 'loading_widget.dart';

class AppButton extends StatelessWidget {
  final double cornerRadius;
  final Color? color;
  final String title;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final VoidCallback onClicked;
  final ValueStream<bool>? loadingStream;
  final EdgeInsets padding;
  const AppButton({
    super.key,
    required this.onClicked,
    required this.title,
    this.cornerRadius=AppSizes.s16,
    this.color,
    this.textStyle,
    this.width,
    this.height,
    this.loadingStream,
    this.padding=const EdgeInsets.symmetric(
      horizontal: AppSizes.s16,
      vertical: AppSizes.s12,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StreamBuilder<bool>(
        initialData: false,
        stream: loadingStream,
        builder: (context, loadingSnapshot) {
          if(loadingSnapshot.data??false) return const LoadingWidget();

          return GestureDetector(
            onTap: onClicked,
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color??Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              padding: padding,
              child: Text(
                title,
                style: textStyle??Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        }
      ),
    );
  }
}
