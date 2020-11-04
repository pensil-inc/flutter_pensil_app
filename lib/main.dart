import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/config/configs.dart';
import 'package:flutter_pensil_app/locator.dart';
import 'package:flutter_pensil_app/ui/app.dart';
import 'package:flutter_pensil_app/ui/page/splash.dart';

void main() {
  final config = stableConfig();
  setUpDependency(config);
  final configuredApp = AppConfig(
    config: config,
    child: PensilApp(home: SplashPage()),
  );
  runApp(configuredApp);
}
