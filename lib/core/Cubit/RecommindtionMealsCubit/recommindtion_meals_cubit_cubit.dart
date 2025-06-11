import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Repo/MealRepo.dart';
import 'package:graduation_project_ui/core/helper/getDailyRandomIndexes.dart';
import 'package:meta/meta.dart';

part 'recommindtion_meals_cubit_state.dart';

class RecommindtionMealsCubitCubit extends Cubit<RecommindtionMealsCubitState> {
  final Mealrepo mealrepoimpl;
  RecommindtionMealsCubitCubit({required this.mealrepoimpl})
      : super(RecommindtionMealsCubitInitial());

  Future<void> getRecommindtionMeals(String bodycondition) {
    emit(RecommindtionMealsCubitLoading());
    return mealrepoimpl.getrecommendedMeals(bodycondition).then((value) {
      value.fold(
        (failuers) => emit(RecommindtionMealsCubitFailure(failuers.Massage)),
        (allMeals) {
          if (allMeals.length < 5) {
            emit(RecommindtionMealsCubitFailure("عدد التمارين غير كافي"));
          } else {
            final indexes = getDailyRandomIndexes(total: allMeals.length);
            final dailyExercises = indexes.map((i) => allMeals[i]).toList();
            emit(RecommindtionMealsCubitSuccess(dailyExercises));
          }
        },
      );
    });
  }
}
