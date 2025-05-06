import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';

class FavExerciesRepoImp {
  DatabaseService databaseService;
  FavExerciesRepoImp({required this.databaseService});

  Future<Either<Failuers, List<dynamic>>> getExercises() async {
    try {
      var data =
          await databaseService.fetchFavoriteWorkouts(getCurrentUserId());
      final List<dynamic> exercises = data['favoriteWorkouts']
          .map((e) => Exercisemodel.fromJson(e).toEntity())
          .toList();
      return Right(exercises);
    } on Exception catch (e) {
      return Left(ServerFailuers(e.toString()));
    }
  }
}
