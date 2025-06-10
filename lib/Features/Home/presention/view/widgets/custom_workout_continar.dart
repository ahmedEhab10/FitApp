import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/BottomNavigationModel.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class CustomWorkoutContinar extends StatelessWidget {
  CustomWorkoutContinar({super.key, this.height});
  double? height;

  // Helper function to get responsive outer container height
  double _getOuterContainerHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return screenHeight * 0.16; // Small screens
    if (screenHeight < 700) return screenHeight * 0.18; // Medium screens
    if (screenHeight < 800) return screenHeight * 0.195; // Large phones
    return screenHeight * 0.22; // Tablets and larger
  }

  // Helper function to get responsive inner container height
  double _getInnerContainerHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return screenHeight * 0.12; // Small screens
    if (screenHeight < 700) return screenHeight * 0.14; // Medium screens
    if (screenHeight < 800) return screenHeight * 0.15; // Large phones
    return screenHeight * 0.17; // Tablets and larger
  }

  // Helper function to get responsive inner container width
  double _getInnerContainerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return screenWidth * 0.88; // Small phones
    if (screenWidth < 768) return screenWidth * 0.83; // Phones
    return screenWidth * 0.75; // Tablets and larger
  }

  // Helper function to get responsive title font size
  double _getTitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 18.0; // Small phones
    if (screenWidth < 414) return 20.0; // Medium phones
    if (screenWidth < 768) return 24.0; // Large phones
    if (screenWidth < 1024) return 28.0; // Small tablets
    return 32.0; // Large tablets
  }

  // Helper function to get responsive subtitle font size
  double _getSubtitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 10.0; // Small phones
    if (screenWidth < 414) return 11.0; // Medium phones
    if (screenWidth < 768) return 12.0; // Large phones
    if (screenWidth < 1024) return 13.0; // Small tablets
    return 14.0; // Large tablets
  }

  // Helper function to get responsive padding
  double _getPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 12.0; // Small phones
    if (screenWidth < 414) return 14.0; // Medium phones
    if (screenWidth < 768) return 16.0; // Large phones
    return 20.0; // Tablets and larger
  }

  // Helper function to get responsive image height
  double _getImageHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final innerHeight = _getInnerContainerHeight(context);
    return innerHeight * 0.8; // Image takes 80% of inner container height
  }

  @override
  Widget build(BuildContext context) {
    final outerHeight = height ?? _getOuterContainerHeight(context);
    final innerHeight = _getInnerContainerHeight(context);
    final innerWidth = _getInnerContainerWidth(context);
    final titleFontSize = _getTitleFontSize(context);
    final subtitleFontSize = _getSubtitleFontSize(context);
    final padding = _getPadding(context);
    final imageHeight = _getImageHeight(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: outerHeight,
      decoration: const BoxDecoration(color: Color(0xffB3A0FF)),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff232323),
            borderRadius: BorderRadius.circular(20),
          ),
          height: innerHeight,
          width: innerWidth,
          child: Padding(
            padding: EdgeInsets.only(left: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly\nChallenge',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: const Color(0xffE2F163),
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: padding * 0.25),
                      Text(
                        'Plank With Hip Twist',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: imageHeight,
                    child: Image.asset(
                      Assets.assetsImagesWomanHelpingManGym2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class navigatorIcon extends StatelessWidget {
  const navigatorIcon({
    super.key,
    required this.isActive,
    required this.bottomNavigationBarEntity,
  });
  final bool isActive;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveIcon(
            image: bottomNavigationBarEntity.Activeimage,
            title: bottomNavigationBarEntity.title,
          )
        : inActiveIcon(image: bottomNavigationBarEntity.Activeimage);
  }
}

class inActiveIcon extends StatelessWidget {
  const inActiveIcon({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(image);
  }
}

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({super.key, required this.image, required this.title});
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        decoration: ShapeDecoration(
          color: const Color(0xFFEEEEEE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: const Color(0xFF1B5E37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(child: SvgPicture.asset(image)),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1B5E37),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
