import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';

class ArticlesItem extends StatelessWidget {
  const ArticlesItem(
      {super.key,
      required this.image,
      required this.title,
      required this.articalentity});
  final String image, title;
  final Articalentity articalentity;

  // Helper function to get responsive image height
  double _getImageHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenHeight < 600) return 100.0; // Small screens
    if (screenHeight < 700) return 120.0; // Medium screens
    if (screenWidth > 600) return 160.0; // Tablets
    return 135.0; // Default for large phones
  }

  // Helper function to get responsive image width
  double _getImageWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) return 140.0; // Small phones
    if (screenWidth < 414) return 155.0; // Medium phones
    if (screenWidth < 768) return 165.0; // Large phones
    if (screenWidth < 1024) return 200.0; // Small tablets
    return 220.0; // Large tablets
  }

  // Helper function to get responsive font size
  double _getFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) return 11.0; // Small phones
    if (screenWidth < 414) return 12.0; // Medium phones
    if (screenWidth < 768) return 13.0; // Large phones
    if (screenWidth < 1024) return 15.0; // Small tablets
    return 16.0; // Large tablets
  }

  // Helper function to get responsive icon size
  double _getIconSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) return 18.0; // Small phones
    if (screenWidth < 414) return 20.0; // Medium phones
    if (screenWidth < 768) return 22.0; // Large phones
    return 24.0; // Tablets and larger
  }

  // Helper function to get responsive spacing
  double _getSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenHeight < 600) return 6.0; // Small screens
    if (screenHeight < 800) return 8.0; // Medium screens
    return 10.0; // Large screens
  }

  @override
  Widget build(BuildContext context) {
    final imageHeight = _getImageHeight(context);
    final imageWidth = _getImageWidth(context);
    final fontSize = _getFontSize(context);
    final iconSize = _getIconSize(context);
    final spacing = _getSpacing(context);

    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: imageHeight,
                width: imageWidth,
                child: Image.network(
                  articalentity.image!,
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: imageHeight,
                      width: imageWidth,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: iconSize * 2,
                        color: Colors.grey,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: imageHeight,
                      width: imageWidth,
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 8,
              child: Icon(
                Icons.star,
                color: Colors.grey,
                size: iconSize,
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
        SizedBox(
          width: imageWidth,
          child: Text(
            articalentity.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
