import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Size_config.dart';
import 'package:graduation_project_ui/core/Utils/AppRouter.dart';
import 'package:graduation_project_ui/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  SharedPreferencesSinglton.init();
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
      debugShowCheckedModeBanner: false,
    );
  }
}
// AMAR YASSER
