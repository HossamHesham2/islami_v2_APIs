import 'package:flutter/material.dart';
import 'package:islami_v2/core/routes_manager.dart';
import 'package:islami_v2/core/themes_manager.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.getRoute,
      initialRoute: initialRoute,
      theme: ThemesManager.darkTheme,
    );
  }
}

