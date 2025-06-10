import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';
import 'package:graduation_project_ui/core/helper/getBodyCondition.dart';
import 'package:graduation_project_ui/core/helper/getDailyRandomIndexes.dart';

class HomaPageHeader extends StatelessWidget {
  const HomaPageHeader({super.key});

  // Helper function to get responsive font size for the name
  double _getNameFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 18.0; // Small phones
    if (screenWidth < 414) return 20.0; // Medium phones
    if (screenWidth < 768) return 23.0; // Large phones
    if (screenWidth < 1024) return 26.0; // Tablets
    return 30.0; // Large tablets/desktops
  }

  // Helper function to get responsive font size for subtitle
  double _getSubtitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 11.0; // Small phones
    if (screenWidth < 414) return 12.0; // Medium phones
    if (screenWidth < 768) return 13.0; // Large phones
    if (screenWidth < 1024) return 14.0; // Tablets
    return 16.0; // Large tablets/desktops
  }

  // Helper function to get responsive icon size
  double _getIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return 20.0; // Small phones
    if (screenWidth < 414) return 22.0; // Medium phones
    if (screenWidth < 768) return 24.0; // Large phones
    if (screenWidth < 1024) return 26.0; // Tablets
    return 28.0; // Large tablets/desktops
  }

  @override
  Widget build(BuildContext context) {
    final nameFontSize = _getNameFontSize(context);
    final subtitleFontSize = _getSubtitleFontSize(context);
    final iconSize = _getIconSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Hi, ${GetUser().name}',
                style: TextStyle(
                  color: const Color(0XFF896CFE),
                  fontSize: nameFontSize,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    log(GetUser().bodyCondition.toString());
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: KDarkerPrimaryColor,
                    size: iconSize,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: const EdgeInsets.all(4),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push('/User_profile');
                    },
                    icon: Icon(
                      Icons.person_3,
                      color: const Color(0XFF896CFE),
                      size: iconSize,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    padding: const EdgeInsets.all(4),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        Text(
          'It\'s time to challenge your limits.',
          style: TextStyle(
            color: Colors.white,
            fontSize: subtitleFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
