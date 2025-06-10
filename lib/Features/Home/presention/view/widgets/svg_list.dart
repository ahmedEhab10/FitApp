import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/Svg_Model.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/svg_item.dart';

import 'package:graduation_project_ui/core/Utils/App_images.dart';

class SvgList extends StatelessWidget {
  const SvgList({super.key});

  static var items = [
    SvgModel(
      image: Assets.assetsSvgWorkout,
      color: const Color(0XFF896CFE),
      text: 'Workout',
    ),
    SvgModel(
      image: Assets.assetsSvgProgress,
      color: const Color(0XFF896CFE),
      text: 'Progress',
    ),
    SvgModel(
      image: Assets.assetsSvgNutritionicon,
      color: const Color(0XFF896CFE),
      text: 'Nutrition',
    ),
    SvgModel(
      image: Assets.assetsSvgCommunityicon,
      color: const Color(0XFF896CFE),
      text: 'Community',
    ),
  ];

  // Helper function to get responsive height
  double _getResponsiveHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) return 50.0; // Small screens
    if (screenHeight < 800) return 60.0; // Medium screens
    return 70.0; // Large screens
  }

  // Helper function to get responsive padding
  double _getItemPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 6.0; // Small phones
    if (screenWidth < 414) return 8.0; // Medium phones
    if (screenWidth < 768) return 10.0; // Large phones
    return 12.0; // Tablets and larger
  }

  // Helper function to get responsive divider width
  double _getDividerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 8.0; // Small phones
    if (screenWidth < 414) return 12.0; // Medium phones
    return 15.0; // Larger phones and tablets
  }

  @override
  Widget build(BuildContext context) {
    final responsiveHeight = _getResponsiveHeight(context);
    final itemPadding = _getItemPadding(context);
    final dividerWidth = _getDividerWidth(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: responsiveHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Check if we need to scroll horizontally on very small screens
          final needsScroll = screenWidth < 320;

          if (needsScroll) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildNavigationItems(
                    itemPadding, dividerWidth, responsiveHeight, context),
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildNavigationItemsFlexible(
                  itemPadding, dividerWidth, responsiveHeight, context),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildNavigationItems(double itemPadding, double dividerWidth,
      double height, BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          GoRouter.of(context).push('/WorkOut_view');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: itemPadding),
          child: SvgItem(svgModel: items[0], height: 7),
        ),
      ),
      _buildDivider(dividerWidth, height),
      GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: itemPadding),
          child: SvgItem(svgModel: items[1], height: 7),
        ),
      ),
      _buildDivider(dividerWidth, height),
      GestureDetector(
        onTap: () {
          GoRouter.of(context).push('/Nutritions_view');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: itemPadding),
          child: SvgItem(svgModel: items[2], height: 7),
        ),
      ),
      _buildDivider(dividerWidth, height),
      GestureDetector(
        onTap: () {
          GoRouter.of(context).push('/Community_view');
        },
        child: Padding(
          padding: EdgeInsets.only(left: itemPadding),
          child: SvgItem(svgModel: items[3], height: 18),
        ),
      ),
    ];
  }

  List<Widget> _buildNavigationItemsFlexible(double itemPadding,
      double dividerWidth, double height, BuildContext context) {
    return [
      Flexible(
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).push('/WorkOut_view');
          },
          child: SvgItem(svgModel: items[0], height: 7),
        ),
      ),
      _buildDivider(dividerWidth, height),
      Flexible(
        child: GestureDetector(
          onTap: () {},
          child: SvgItem(svgModel: items[1], height: 7),
        ),
      ),
      _buildDivider(dividerWidth, height),
      Flexible(
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).push('/Nutritions_view');
          },
          child: SvgItem(svgModel: items[2], height: 7),
        ),
      ),
      _buildDivider(dividerWidth, height),
      Flexible(
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).push('/Community_view');
          },
          child: SvgItem(svgModel: items[3], height: 18),
        ),
      ),
    ];
  }

  Widget _buildDivider(double width, double height) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        width: width,
        thickness: 1,
        color: const Color(0xFFB3A0FF),
      ),
    );
  }
}
