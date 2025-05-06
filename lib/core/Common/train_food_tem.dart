import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Store_Service.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';

class Train_food_Item extends StatefulWidget {
  Train_food_Item(
      {super.key, required this.image, required this.exerciseEntity});
  final String image;
  final ExerciseEntity exerciseEntity;
  final DatabaseService databaseService = FireBaseStoreService();

  @override
  State<Train_food_Item> createState() => _Train_food_ItemState();
}

class _Train_food_ItemState extends State<Train_food_Item> {
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfFavorite();
  }

  void checkIfFavorite() async {
    final favList =
        await widget.databaseService.fetchFavoriteWorkouts(getCurrentUserId());
    final favorites = (favList['favorites'] as List)
        .map((e) => Exercisemodel.fromJson(e).id)
        .toList();
    setState(() {
      isFavorite = favorites.contains(widget.exerciseEntity.id);
    });
  }

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
            child: Stack(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        width: 140,
                        height: 100,
                        image: NetworkImage(
                            widget.exerciseEntity.image!), //AssetImage(image),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image,
                              size: 50, color: Colors.grey);
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 12, right: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              widget.exerciseEntity.name,
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
                                widget.exerciseEntity.duration.toString(),
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
                                widget.exerciseEntity.calories.toString(),
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
                              )
                            ]),
                            Visibility(
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.assetsSvgExercies),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${widget.exerciseEntity.repetitions} exercises',
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
                Positioned(
                  top: 1,
                  left: 310,
                  child: IconButton(
                    onPressed: () async {
                      //  final favcubit = context.read<FavExrciesCubit>();

                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      if (isFavorite) {
                        context
                            .read<FavExrciesCubit>()
                            .addFavExercises(widget.exerciseEntity);

                        // widget.databaseService.addWorkoutToFavorites(
                        //     getCurrentUserId(),
                        //     widget.exerciseEntity.toModel());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${widget.exerciseEntity.name} added to favorites')),
                        );
                      } else {
                        context
                            .read<FavExrciesCubit>()
                            .removeFromFavorites(widget.exerciseEntity);

                        // widget.databaseService.removeWorkoutFromFavorites(
                        //     getCurrentUserId(),
                        //     widget.exerciseEntity.toModel());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${widget.exerciseEntity.name} removed from favorites')),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.favorite_outlined,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
