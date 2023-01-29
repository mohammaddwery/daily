import 'package:flutter/material.dart';
import '../../core/core_constants.dart';
import '../helpers/app_icons.dart';
import '../styles/app_fonts.dart';
import '../styles/app_sizes.dart';
import 'image_button_widget.dart';

class GeneralAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackClicked;
  final List<Widget> actions;
  final bool hasBackButton;
  const GeneralAppbar(
      this.title, {
        this.onBackClicked,
        this.hasBackButton=true,
        this.actions=const [],
        Key? key,
      }) : super(key: key);


  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s52);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top,),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8,),
      height: preferredSize.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(hasBackButton) ImageButtonWidget(
            onClicked: () => onBackClicked != null ? onBackClicked!() : Navigator.of(context).pop(),
            packageName: CoreConstants.packageName,
            imageUrl: AppIcons.arrowBack,
            height: AppSizes.s16,
            width: AppSizes.s16,
          ),
          const SizedBox(width: AppSizes.s8,),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade900,
                fontWeight: AppFonts.medium,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSizes.s8,),
          ...actions,
        ],
      ),
    );
  }
}