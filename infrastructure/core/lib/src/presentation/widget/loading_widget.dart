import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double paddingValue;
  final Color? color;
  const LoadingWidget({super.key, this.paddingValue=8.0, this.color});
    @override
    Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingValue),
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(color??Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
