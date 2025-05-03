import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Fav_View/Widget/Fav_View_Body.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Exercies_Repo_Imp.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title: const Text('Favorite WorkOut',
              style: TextStyle(color: KPrimaryColor)),
        ),
        body: SafeArea(
            child: BlocProvider(
          create: (context) => FavExrciesCubit(
              favExerciesRepoImp: getIt.get<FavExerciesRepoImp>()),
          child: FavViewBody(),
        )));
  }
}
