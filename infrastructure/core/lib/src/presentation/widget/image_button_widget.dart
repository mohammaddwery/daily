import 'package:flutter/material.dart';
import '../styles/app_sizes.dart';
import 'image_widget.dart';

class ImageButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String packageName;
  final String imageUrl;
  final Color? color;
  final double width;
  final double height;
  final double padding;
  const ImageButtonWidget({
    super.key,
    required this.packageName,
    required this.onClicked,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.color,
    this.padding=AppSizes.s8,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      radius: width,
      borderRadius: BorderRadius.circular(width),
      splashColor: Theme.of(context).primaryColor.withOpacity(.35),
      focusColor: Theme.of(context).primaryColor.withOpacity(.65),
      highlightColor: Theme.of(context).primaryColor.withOpacity(.35),
      hoverColor: Colors.white.withOpacity(.25),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: ImageWidget(
          packageName: packageName,
          url: imageUrl,
          color: color,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
