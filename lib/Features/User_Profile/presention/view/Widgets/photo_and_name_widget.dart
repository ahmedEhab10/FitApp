import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class photo_and_name_widget extends StatelessWidget {
  const photo_and_name_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(child: Image.asset(Assets.assetsImagesProfilePhoto)),
        const Text(
          'Madison smith',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Madison220@gmao.com',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
