import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project_ui/Features/Auth/data/Models/User_Model.dart';

import '../Models/ExerciseModel.dart';

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  });

  Future<void> addUserData(UserModel user);

  Future<void> addWorkoutToFavorites(
      String userId, Exercisemodel exercisemodel);

  Future<void> removeWorkoutFromFavorites(
      String userId, Exercisemodel exercisemodel);

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchFavoriteWorkouts(
      String userI);
}
