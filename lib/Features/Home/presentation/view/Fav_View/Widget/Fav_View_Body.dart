import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presentation/view/Fav_View/Widget/Fav_Exercies_List_View.dart';

import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class FavViewBody extends StatefulWidget {
  const FavViewBody({super.key});

  @override
  State<FavViewBody> createState() => _FavViewBodyState();
}

class _FavViewBodyState extends State<FavViewBody> {
  @override
  void initState() {
    context.read<FavExrciesCubit>().getFavExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Let\'s Go Favorite WorkOut',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Explore Different Workout Stylest',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          List_View_blocBuilder()
        ],
      ),
    );
  }
}

class List_View_blocBuilder extends StatelessWidget {
  const List_View_blocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavExrciesCubit, FavExrciesState>(
      builder: (context, state) {
        if (state is FavExrciesLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KPrimaryColor,
          ));
        } else if (state is FavExrciesSuccess) {
          final favList = state.Fav_exercise;
          return Fav_Exercies_List_View(
            Exerciselist: favList,
          );
        } else {
          return const Text('Error');
        }
      },
    );
  }
}
