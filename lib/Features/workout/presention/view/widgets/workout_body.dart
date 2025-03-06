import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/const.dart';
import 'package:graduation_project_ui/core/Common/custom_appBar.dart';
import 'package:graduation_project_ui/core/Common/train_food_tem.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class WorkoutBody extends StatelessWidget {
  const WorkoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Let\'s Go WorkOut',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Explore Different Workout Stylest',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 40,
            itemBuilder: (context, index) => const Train_food_Item(
              image: Assets.assetsImagesUpperBody,
              title: 'upper body',
              calories: '1320 Kcal',
              time: '60 Minutes',
            ),
          )
        ],
      ),
    );

    //ListView.builder(
    //   itemCount: 40,
    //   itemBuilder: (context, index) => const TrainItem(),
    // );
  }
}
