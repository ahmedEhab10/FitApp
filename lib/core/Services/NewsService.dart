import 'package:dio/dio.dart';
import 'package:graduation_project_ui/Features/community/Models/articals_model.dart';

class NewsService {
  Dio dio;
  NewsService(this.dio);

  Future<List<ArticalsModel>> getNews(String q) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything?q=$q&apiKey=8d90f60fcf0e40a9ba95791281c302e3',
      );

      var jsonData = response.data;
      List<dynamic> articalList = jsonData['articles'];
      List<ArticalsModel> news = [];

      for (var artical in articalList) {
        try {
          // Skip articles with null or empty essential data
          if (artical['title'] == null ||
              artical['title'].toString().trim().isEmpty) {
            continue;
          }

          // Handle image URL - provide null if image is missing or invalid
          String? imageUrl = artical['urlToImage'];
          if (imageUrl != null && imageUrl.trim().isEmpty) {
            imageUrl = null;
          }

          ArticalsModel articals = ArticalsModel(
            image: imageUrl,
            title: artical['title'],
            subtitle: artical['description'],
            content: artical['content'] ?? '',
            url: artical['url'] ?? '',
            publishedAt: artical['publishedAt'] ?? '',
            author: artical['author'] ?? 'Anonymous',
          );
          news.add(articals);
        } catch (e) {
          // Skip this article if there's an error processing it
          print('Error processing article: $e');
          continue;
        }
      }
      return news;
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }
}
