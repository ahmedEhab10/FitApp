import 'package:flutter/widgets.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Articles_item.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsTrainItem_ai.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Recommendations_widget.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/custom_workout_continar.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/homa_page_header.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/svg_list.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: HomaPageHeader(),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SvgList(),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Recommendations_widget(),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Recommendetion_Row_bloc_Listener(),
          ),
          const SizedBox(height: 12),
          CustomWorkoutContinar(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Articles & Tips',
              style: TextStyle(
                color: Color(0xffE2F163),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ArticlesItem(
                    image: Assets.assetsImagesWomanEating,
                    title: 'The Science of Eating Well',
                  ),
                  SizedBox(width: 26),
                  ArticlesItem(
                    image: Assets.assetsImagesManTraining,
                    title: '15 Quick & Effective Daily',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Recommendetion_Row_bloc_Listener extends StatelessWidget {
  const Recommendetion_Row_bloc_Listener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RecommendationstrainitemAi(),
        RecommendationstrainitemAi(),
      ],
    );
  }
}
