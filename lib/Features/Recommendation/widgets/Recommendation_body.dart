import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsTrainItem_ai.dart';
import 'package:graduation_project_ui/core/Cubit/RecommindtionExercies_Cubit/recommindtion_exercies_cubit.dart';
import 'package:graduation_project_ui/core/Cubit/RecommindtionMealsCubit/recommindtion_meals_cubit_cubit.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';

class RecommendationBody extends StatefulWidget {
  const RecommendationBody({super.key});

  @override
  State<RecommendationBody> createState() => _RecommendationBodyState();
}

class _RecommendationBodyState extends State<RecommendationBody> {
  @override
  void initState() {
    context
        .read<RecommindtionExerciesCubit>()
        .getRecommindtionExercies(GetUser().bodyCondition.toString());

    context
        .read<RecommindtionMealsCubitCubit>()
        .getRecommindtionMeals(GetUser().bodyCondition.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView_BLocBuilder();
  }
}

class GridView_BLocBuilder extends StatelessWidget {
  const GridView_BLocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExercisesGridViewBlocBuilder(),
          Divider(height: 2.5, color: KPrimaryColor),
          MealsGridViewBlocBuilder(),
        ],
      ),
    );
  }
}

// تمارين
class ExercisesGridViewBlocBuilder extends StatelessWidget {
  const ExercisesGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended Exercises',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: KPacScoundColor),
        ),
        const SizedBox(height: 8),
        BlocBuilder<RecommindtionExerciesCubit, RecommindtionExerciesState>(
          builder: (context, state) {
            if (state is RecommindtionExerciesLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecommindtionExerciesSuccess) {
              final exercises = state.Exerciselist;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return RecommendationstrainitemAi(
                    title: exercise.name,
                    image: exercise.image!,
                    duration: exercise.duration.toString(),
                    calories: exercise.calories.toString(),
                  );
                },
              );
            } else {
              return const Center(child: Text('Error loading exercises'));
            }
          },
        ),
      ],
    );
  }
}

// وجبات
class MealsGridViewBlocBuilder extends StatelessWidget {
  const MealsGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended Meals',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: KPacScoundColor),
        ),
        const SizedBox(height: 8),
        BlocBuilder<RecommindtionMealsCubitCubit, RecommindtionMealsCubitState>(
          builder: (context, state) {
            if (state is RecommindtionMealsCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecommindtionMealsCubitSuccess) {
              final meals = state.Meallist;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return RecommendationstrainitemAi(
                    title: meal.name,
                    image: meal.image!,
                    calories: meal.Calories.toString(),
                    duration: '12',
                  );
                },
              );
            } else {
              return const Center(child: Text('Error loading meals'));
            }
          },
        ),
      ],
    );
  }
}
//  RecommendationstrainitemAi(
//               title: 'squat Exercise',
//               image: Assets.assetsImagesWomanHelpingManGym,
//               duration: '12',
//               calories: '20',
//             ),
