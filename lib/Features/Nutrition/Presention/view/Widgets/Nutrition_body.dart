import 'package:flutter/material.dart';
import 'package:graduation_project_ui/const.dart';
import 'package:graduation_project_ui/core/Common/train_food_tem.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class NutritionBody extends StatelessWidget {
  const NutritionBody({super.key});

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
              'Recipes for you',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
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
              image: Assets.assetsSvgFoodphoto,
              title: 'Delights with Greek with Chicken ',
              calories: '200 Calories',
              visible: false,
              time: '6 Minutes',
            ),
          )
        ],
      ),
    );
  }
}
