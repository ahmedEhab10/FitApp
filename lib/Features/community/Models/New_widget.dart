import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/Models/articals_model.dart';
import 'package:graduation_project_ui/Features/community/News/View/news_detials.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class NewWidget extends StatelessWidget {
  final ArticalsModel articals;
  NewWidget(this.articals);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetials(artical: articals),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: articals.image != null
                  ? Image.network(
                      articals.image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets
                              .assetsImagesBeautifulYoungSportyManTrainingWorkoutGym3,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          width: double.infinity,
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
                    )
                  : Image.asset(
                      'assets/1200x630wa.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              articals.title!,
              style: TextStyle(
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
              ),
            ),
            articals.subtitle != null
                ? Text(
                    articals.subtitle!,
                    style: TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.blueGrey,
                    ),
                  )
                : Text(
                    ' ',
                    style: TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.blueGrey,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
