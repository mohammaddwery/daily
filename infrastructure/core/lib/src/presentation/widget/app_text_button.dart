import 'package:flutter/material.dart';
import '../styles/app_fonts.dart';
import '../styles/app_sizes.dart';
import 'image_widget.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onClicked;
  final String title;
  final Color? color;
  final String? icon;
  final String? packageName;
  const AppTextButton({
    required this.onClicked,
    required this.title,
    this.color,
    this.icon,
    this.packageName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.s8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(icon!=null && packageName!=null) Padding(
              padding: const EdgeInsets.only(right: AppSizes.s8,),
              child: ImageWidget(
                url: icon!,
                packageName: packageName!,
                height: AppSizes.s16,
                width: AppSizes.s16,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color??Colors.grey.shade900,
                fontWeight: AppFonts.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
