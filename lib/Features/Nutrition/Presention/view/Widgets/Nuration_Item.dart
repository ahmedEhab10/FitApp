import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class NurationItem extends StatelessWidget {
  final Mealentity mealentity;
  const NurationItem({
    required this.mealentity,
    super.key,
  });

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    width: 140,
                    height: 100,
                    image: NetworkImage(mealentity.image!), //AssetImage(image),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image,
                          size: 50, color: Colors.grey);
                    },
                  ),
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
                          mealentity.name,
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
                            '50 Munits',
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
                            '${mealentity.Calories} calories',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          )
                        ]),
                        Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.assetsSvgExercies),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                mealentity.Type,
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
