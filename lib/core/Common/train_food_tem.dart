import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class Train_food_Item extends StatelessWidget {
  const Train_food_Item(
      {super.key,
      this.visible = true,
      required this.image,
      required this.title,
      required this.calories,
      required this.time,
      this.exercises});
  final String image, title, calories, time;
  final String? exercises;
  final bool? visible;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 12, right: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(children: [
                          SvgPicture.asset(Assets.assetsSvgCalories),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SvgPicture.asset(Assets.assetsSvgTime),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            calories,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          )
                        ]),
                        Visibility(
                          visible: visible!,
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.assetsSvgExercies),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '5 exercises',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
