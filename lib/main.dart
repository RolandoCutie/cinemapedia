import 'package:flutter/material.dart';

import 'package:cinemapediafernadoherrera/config/router/app_router.dart';
import 'package:cinemapediafernadoherrera/config/theme/app_theme.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Material App',
    );
  }
}
