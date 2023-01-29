import 'package:flutter/material.dart';
import '../../../core.dart';

class AppCard extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final BoxShadow? shadow;
  final Widget child;
  final VoidCallback? onClicked;
  const AppCard({
    this.color=Colors.white,
    this.shadow,
    this.onClicked,
    this.width,
    this.height,
    this.margin=EdgeInsets.zero,
    this.padding= const EdgeInsets.symmetric(vertical: AppSizes.s24, horizontal: AppSizes.s16,),
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        width:  width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSizes.s16),
          boxShadow: [
            shadow??Theme.of(context).colorScheme.cardShadow,
          ],
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
