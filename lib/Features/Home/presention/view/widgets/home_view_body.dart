import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/ArticlesItem_Detalis.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Articles_item.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsFooditemAi.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsTrainItem_ai.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Recommendations_widget.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/custom_workout_continar.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/homa_page_header.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/svg_list.dart';
import 'package:graduation_project_ui/core/Cubit/Artical_cubit/artical_cubit.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Random_Number.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<ArticalCubit>().getArticals();
    super.initState();
  }

  // Helper function to get responsive padding
  double _getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 12.0; // Small phones
    if (screenWidth < 414) return 16.0; // Medium phones
    if (screenWidth < 768) return 20.0; // Large phones
    if (screenWidth < 1024) return 32.0; // Tablets
    return 40.0; // Large tablets/desktops
  }

  // Helper function to get responsive vertical spacing
  double _getVerticalSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 8.0; // Small screens
    if (screenHeight < 800) return 12.0; // Medium screens
    return 16.0; // Large screens
  }

  @override
  Widget build(BuildContext context) {
    final responsivePadding = _getResponsivePadding(context);
    final verticalSpacing = _getVerticalSpacing(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivePadding),
            child: const HomaPageHeader(),
          ),
          SizedBox(height: verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivePadding),
            child: const SvgList(),
          ),
          SizedBox(height: verticalSpacing * 0.7),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivePadding),
            child: const Recommendations_widget(),
          ),
          SizedBox(height: verticalSpacing * 0.7),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivePadding),
            child: const Recommendetion_Row_bloc_Listener(),
          ),
          SizedBox(height: verticalSpacing),
          CustomWorkoutContinar(),
          SizedBox(height: verticalSpacing * 0.8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivePadding),
            child: const Text(
              'Articles & Tips',
              style: TextStyle(
                color: Color(0xffE2F163),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          const Artical_Row_BlocBuilder(),
          SizedBox(height: verticalSpacing * 2), // Bottom padding
        ],
      ),
    );
  }
}

class Artical_Row_BlocBuilder extends StatelessWidget {
  const Artical_Row_BlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int number1 = RandomNumberGenerator().getRandomNumber(0, 7);
    final int number2 = RandomNumberGenerator().getRandomNumber(0, 7);
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivePadding = screenWidth < 360
        ? 12.0
        : screenWidth < 414
            ? 16.0
            : screenWidth < 768
                ? 20.0
                : screenWidth < 1024
                    ? 32.0
                    : 40.0;

    return BlocBuilder<ArticalCubit, ArticalState>(builder: (context, state) {
      if (state is ArticalLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ArticalSuccess) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: responsivePadding),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if we have enough space for side-by-side layout
              final availableWidth = constraints.maxWidth;
              final shouldUseColumn = availableWidth < 400;

              if (shouldUseColumn) {
                // Stack articles vertically on very small screens
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticlesitemDetalis(
                                    articalentity: state.articals[number1],
                                  )),
                        );
                      },
                      child: ArticlesItem(
                        image: Assets.assetsImagesWomanEating,
                        title: 'The Science of Eating Well',
                        articalentity: state.articals[number1],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticlesitemDetalis(
                                    articalentity: state.articals[number2],
                                  )),
                        );
                      },
                      child: ArticlesItem(
                        image: Assets.assetsImagesManTraining,
                        title: '15 Quick & Effective Daily',
                        articalentity: state.articals[number2],
                      ),
                    ),
                  ],
                );
              } else {
                // Use row layout for larger screens
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticlesitemDetalis(
                                      articalentity: state.articals[number1],
                                    )),
                          );
                        },
                        child: ArticlesItem(
                          image: Assets.assetsImagesWomanEating,
                          title: 'The Science of Eating Well',
                          articalentity: state.articals[number1],
                        ),
                      ),
                    ),
                    SizedBox(width: availableWidth * 0.05),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticlesitemDetalis(
                                      articalentity: state.articals[number2],
                                    )),
                          );
                        },
                        child: ArticlesItem(
                          image: Assets.assetsImagesManTraining,
                          title: '15 Quick & Effective Daily',
                          articalentity: state.articals[number2],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      } else {
        return const Text('Error');
      }
    });
  }
}

class Recommendetion_Row_bloc_Listener extends StatelessWidget {
  const Recommendetion_Row_bloc_Listener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticalCubit, ArticalState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final shouldUseColumn = availableWidth < 400;
            final spacing = availableWidth * 0.03;

            if (shouldUseColumn) {
              // Stack recommendations vertically on small screens
              return Column(
                children: [
                  RecommendationsFooditemAi(
                    title: 'squat Exercise',
                    image: Assets.assetsImagesWomanHelpingManGym,
                    duration: '12',
                    calories: '20',
                  ),
                  SizedBox(height: spacing),
                  RecommendationsFooditemAi(
                    title: 'Fruit salad',
                    image: Assets.assetsImagesEgg,
                    duration: '10',
                    calories: '15',
                  ),
                ],
              );
            } else {
              // Use row layout for larger screens
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: RecommendationsFooditemAi(
                      title: 'squat Exercise',
                      image: Assets.assetsImagesWomanHelpingManGym,
                      duration: '12',
                      calories: '20',
                    ),
                  ),
                  SizedBox(width: spacing),
                  Flexible(
                    child: RecommendationsFooditemAi(
                      title: 'Fruit salad',
                      image: Assets.assetsImagesEgg,
                      duration: '10',
                      calories: '15',
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
