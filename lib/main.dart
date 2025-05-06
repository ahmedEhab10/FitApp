import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Size_config.dart';
import 'package:graduation_project_ui/core/Utils/AppRouter.dart';
import 'package:graduation_project_ui/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Exercies_Repo_Imp.dart';
import 'package:graduation_project_ui/core/Repo/MealRepo.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  SharedPreferencesSinglton.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => FavExrciesCubit(
            favExerciesRepoImp: getIt.get<FavExerciesRepoImp>()),
      ),
    ],
    child: const MyApp(),
  ));
}

// Initialize location services
Future<void> _initializeLocationServices() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Service is not enabled, show dialog or handle as needed
    print('Location services are disabled.');
  }

  // Check permission status
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Request permission
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permission still denied
      print('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are permanently denied
    print('Location permissions are permanently denied');
  }
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
