import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';

class ExerciesDetiels extends StatelessWidget {
  const ExerciesDetiels({super.key, required this.exerciseEntity});
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(
            exerciseEntity.name,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            exerciseEntity.description,
            style: const TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            exerciseEntity.calories.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            exerciseEntity.duration.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      )),
    );
  }
}
