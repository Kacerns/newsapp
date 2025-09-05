import 'package:dio/dio.dart';
import 'package:newsapp/core/errors/server_exception.dart';
import 'package:newsapp/core/constants/news_app_constants.dart';
import 'package:newsapp/features/NewsApp/data/models/news_article_model.dart';

abstract class NewsDataSource {
  Future<List<NewsArticleModel>> getNewsArticlesFromSource({String? category});
}

class NewsDataSourceImpl implements NewsDataSource {
  final Dio _dio;

  NewsDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<NewsArticleModel>> getNewsArticlesFromSource({
    String? category,
  }) async {
    try {
      final queryParams = {
        'country': 'us',
        'category': category,
        'pageSize': 20,
      };

      final response = await _dio.get(
        NewsAppConstants.baseUrl + NewsAppConstants.topHeadlinesEndpoint,
        options: Options(headers: {'X-API-Key': NewsAppConstants.apiKey}),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final articlesJsonList = data['articles'] as List;

        final List<NewsArticleModel> newsArticleModelList = articlesJsonList
            .map((json) => NewsArticleModel.fromJson(json))
            .toList();

        return newsArticleModelList;
      } else {
        throw ServerException(message: "Error: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
