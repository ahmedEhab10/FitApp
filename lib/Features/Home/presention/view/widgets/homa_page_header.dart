import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/const.dart';

class HomaPageHeader extends StatelessWidget {
  const HomaPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hi, Madison',
              style: TextStyle(
                color: Color(0XFF896CFE),
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications,
                      color: KDarkerPrimaryColor),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push('/User_profile');
                    },
                    icon: Icon(Icons.person_3, color: Color(0XFF896CFE)),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Text(
          'It\'s time to challenge your limits.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
