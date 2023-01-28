import 'package:flutter/material.dart';
import '../app_start.dart';
import 'production_build_config.dart';

class ProductionApp extends AppStart {
  ProductionApp() : super(ProductionBuildConfig());
}

Future<void> main() async {
  debugPrint = (String? message, {int? wrapWidth}) {};
  ProductionApp().startApp();
}
