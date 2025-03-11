import 'package:flutter/material.dart';

class ArticlesItem extends StatelessWidget {
  const ArticlesItem({super.key, required this.image, required this.title});
  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(image),
            ),
            const Positioned(
              top: 4,
              left: 125,
              child: Icon(Icons.star, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
