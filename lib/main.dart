import 'package:flutter/material.dart';
import 'package:graduation_project_ui/const.dart';
import 'package:graduation_project_ui/core/Size_config.dart';
import 'package:graduation_project_ui/core/Utils/AppRouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      routerConfig: AppRoute.router,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: KbackGroundColor),
    );
  }
}
