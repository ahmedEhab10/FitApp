import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? profileImage,
    double? weight,
    double? height,
    String? gender,
    int? age,
    String? bodyCondition,
    List<String> recommendedWorkouts = const [],
    List<String> favoriteWorkouts = const [],
    List<String> recommendedMeals = const [],
  }) : super(
          id: id,
          name: name,
          email: email,
          profileImage: profileImage,
          weight: weight,
          height: height,
          gender: gender,
          age: age,
          bodyCondition: bodyCondition,
          recommendedWorkouts: recommendedWorkouts,
          favoriteWorkouts: favoriteWorkouts,
          recommendedMeals: recommendedMeals,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImage: map['profileImage'],
      weight: map['weight']?.toDouble(),
      height: map['height']?.toDouble(),
      gender: map['gender'],
      age: map['age']?.toInt(),
      bodyCondition: map['bodyCondition'],
      recommendedWorkouts: List<String>.from(map['recommendedWorkouts'] ?? []),
      favoriteWorkouts: List<String>.from(map['favoriteWorkouts'] ?? []),
      recommendedMeals: List<String>.from(map['recommendedMeals'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'weight': weight,
      'height': height,
      'gender': gender,
      'age': age,
      'bodyCondition': bodyCondition,
      'recommendedWorkouts': recommendedWorkouts,
      'favoriteWorkouts': favoriteWorkouts,
      'recommendedMeals': recommendedMeals,
    };
  }
}
