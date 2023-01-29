import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorPlaceholderWidget extends StatelessWidget {
  final String messageKey;
  final Widget? refreshButton;
  final String? image;
  final String? packageName;
  const ErrorPlaceholderWidget(this.messageKey, {super.key, this.refreshButton, this.image, this.packageName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(image != null && packageName != null ) ImageWidget(
              url: image!,
              packageName: packageName!,
              width: AppSizes.s150,
              height: AppSizes.s150,
            ),

            const SizedBox(height: AppSizes.s16,),

            Text(
              messageKey,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            if(refreshButton!=null) const SizedBox(height: AppSizes.s24,),
            if(refreshButton!=null) refreshButton!,
          ],
        ),
      ),
    );
  }


}
