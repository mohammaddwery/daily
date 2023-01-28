import 'package:flutter/material.dart';

abstract class BaseWidgetState<ScreenWidget extends StatefulWidget>
    extends State<ScreenWidget>
    with WidgetsBindingObserver {

  late double width;
  late double height;
  late MediaQueryData mediaQuery;
  late TextTheme textTheme;
  late ThemeData themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      mediaQuery = MediaQuery.of(context);
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
      themeData = Theme.of(context);
      textTheme = themeData.textTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  Widget buildContent(BuildContext context);
}
