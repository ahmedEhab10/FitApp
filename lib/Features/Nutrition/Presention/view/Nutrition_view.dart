import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Nutrition/Presention/view/Widgets/Nutrition_body.dart';
import 'package:graduation_project_ui/const.dart';

class NutritionView extends StatelessWidget {
  const NutritionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title:
              const Text('Nutrition', style: TextStyle(color: KPrimaryColor)),
        ),
        body: const NutritionBody());
  }
}
