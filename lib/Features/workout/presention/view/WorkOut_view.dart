import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/workout/presention/view/widgets/workout_body.dart';
import 'package:graduation_project_ui/const.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title: const Text('WorkOut', style: TextStyle(color: KPrimaryColor)),
        ),
        body: const SafeArea(child: WorkoutBody()));
  }
}
