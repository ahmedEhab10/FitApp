import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Exercies_Repo_Imp.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';
part 'fav_exrcies_state.dart';

class FavExrciesCubit extends Cubit<FavExrciesState> {
  final FavExerciesRepoImp favExerciesRepoImp;
  FavExrciesCubit({required this.favExerciesRepoImp})
      : super(FavExrciesInitial());

  Future<void> getFavExercises() async {
    emit(FavExrciesLoading());
    var result = await favExerciesRepoImp.getExercises();
    result.fold((failuers) => emit(FavExrciesFailure(failuers.Massage)),
        (products) => emit(FavExrciesSuccess(products)));
  }

  Future<void> addFavExercises(ExerciseEntity exercisentity) async {
    await favExerciesRepoImp.databaseService
        .addWorkoutToFavorites(getCurrentUserId(), exercisentity.toModel());
    getFavExercises();
  }

  Future<void> removeFromFavorites(ExerciseEntity exercise) async {
    await favExerciesRepoImp.databaseService
        .removeWorkoutFromFavorites(getCurrentUserId(), exercise.toModel());
    getFavExercises(); // إعادة تحميل القائمة
  }
}
