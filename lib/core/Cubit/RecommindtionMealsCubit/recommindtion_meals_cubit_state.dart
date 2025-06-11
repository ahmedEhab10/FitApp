part of 'recommindtion_meals_cubit_cubit.dart';

@immutable
sealed class RecommindtionMealsCubitState {}

final class RecommindtionMealsCubitInitial
    extends RecommindtionMealsCubitState {}

final class RecommindtionMealsCubitLoading
    extends RecommindtionMealsCubitState {}

final class RecommindtionMealsCubitFailure
    extends RecommindtionMealsCubitState {
  final String message;
  RecommindtionMealsCubitFailure(this.message);
}

final class RecommindtionMealsCubitSuccess
    extends RecommindtionMealsCubitState {
  final List<Mealentity> Meallist;
  RecommindtionMealsCubitSuccess(this.Meallist);
}
