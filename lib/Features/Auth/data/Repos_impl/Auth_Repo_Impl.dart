import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:graduation_project_ui/core/Errors/Exaption.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';

class AuthRepoImpl extends AuthRepo {
  final FireBaseAuthService firebaseAuthService;

  AuthRepoImpl({required this.firebaseAuthService});
  @override
  Future<Either<Failuers, UserEntity>> createUserWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email, password);

      var userentity = UserEntity(id: user.uid, name: name, email: email);
      return Right(userentity);
    } on Custom_Exaption catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      return Left(ServerFailuers(e.message));
    } catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      log(
        'there is an error in firebase auth service . create user with email and password and ${e.toString()} ',
      );
      return Left(ServerFailuers('يوجد مشكله حاول مره اخري'));
    }
  }

  @override
  Future<Either<Failuers, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }
}
