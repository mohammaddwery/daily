import 'package:flutter/material.dart';

mixin AppNavigator {
  Future<R?> navigateTo<R, A>({
    required BuildContext context,
    required String routeName,
    A? arguments,
  }) async {
    return Navigator.of(context).pushNamed<R>(
      routeName,
      arguments: arguments,
    );
  }

  Future<R?> navigateReplacement<R, A>({
    required BuildContext context,
    required String routeName,
    A? arguments,
  }) => Navigator.of(context).pushReplacementNamed<R, A>(
    routeName,
    arguments: arguments,
  );


  Future<R?> navigateAndRemoveUntil<R, A>({
    required BuildContext context,
    required String routeName,
    required String anchor,
    A? arguments,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil<R>(
      routeName,
          (route) => route.settings.name == anchor,
      arguments: arguments,
    );
  }
}
