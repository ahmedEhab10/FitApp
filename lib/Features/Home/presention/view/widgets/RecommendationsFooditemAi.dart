import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class RecommendationsFooditemAi extends StatelessWidget {
  const RecommendationsFooditemAi(
      {super.key,
      required this.title,
      required this.image,
      required this.duration,
      required this.calories});
  final String title, image, duration, calories;

  // Helper function to get responsive image height
  double _getImageHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 80.0; // Small screens
    if (screenHeight < 800) return 100.0; // Medium screens
    return 120.0; // Large screens
  }

  // Helper function to get responsive title font size
  double _getTitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 13.0; // Small phones
    if (screenWidth < 414) return 14.0; // Medium phones
    if (screenWidth < 768) return 16.0; // Large phones
    return 18.0; // Tablets and larger
  }

  // Helper function to get responsive subtitle font size
  double _getSubtitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 10.0; // Small phones
    if (screenWidth < 414) return 11.0; // Medium phones
    if (screenWidth < 768) return 12.0; // Large phones
    return 13.0; // Tablets and larger
  }

  // Helper function to get responsive icon size
  double _getIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 14.0; // Small phones
    if (screenWidth < 414) return 15.0; // Medium phones
    if (screenWidth < 768) return 16.0; // Large phones
    return 18.0; // Tablets and larger
  }

  // Helper function to get responsive padding
  double _getPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 6.0; // Small phones
    if (screenWidth < 414) return 7.0; // Medium phones
    if (screenWidth < 768) return 8.0; // Large phones
    return 10.0; // Tablets and larger
  }

  // Helper function to get responsive width percentage
  double _getWidthPercentage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 0.44; // Small phones - slightly wider
    if (screenWidth < 768) return 0.43; // Phones
    return 0.40; // Tablets and larger - slightly narrower for better proportions
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = _getImageHeight(context);
    final titleFontSize = _getTitleFontSize(context);
    final subtitleFontSize = _getSubtitleFontSize(context);
    final iconSize = _getIconSize(context);
    final padding = _getPadding(context);
    final widthPercentage = _getWidthPercentage(context);

    return Container(
      width: screenWidth * widthPercentage,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  image,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: padding * 0.75),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: KPrimaryColor,
                                size: iconSize,
                              ),
                              SizedBox(width: padding * 0.5),
                              Flexible(
                                child: Text(
                                  '${duration}Muints',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: subtitleFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: padding * 0.5),
                        Flexible(
                          child: Row(
                            children: [
                              Icon(
                                Icons.fireplace,
                                color: KPrimaryColor,
                                size: iconSize,
                              ),
                              SizedBox(width: padding * 0.5),
                              Flexible(
                                child: Text(
                                  '${calories}Kcl',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: subtitleFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const Positioned(
          //   top: 8,
          //   right: 8,
          //   child: Icon(Icons.star, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}
