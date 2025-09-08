import 'package:dio/dio.dart';
import 'package:newsapp/core/errors/exception_errors.dart';
import 'package:newsapp/core/constants/news_app_constants.dart';
import 'package:newsapp/features/NewsApp/data/models/news_article_model.dart';

abstract class NewsDataSource {
  Future<List<NewsArticleModel>> getNewsArticlesFromSource({int? page});
}

class NewsDataSourceImpl implements NewsDataSource {
  final Dio _dio;

  NewsDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<NewsArticleModel>> getNewsArticlesFromSource({int? page}) async {
    try {
      final queryParams = {'country': 'us', 'pageSize': 20, 'page': page ?? 1};

      final response = await _dio.get(
        NewsAppConstants.baseUrl + NewsAppConstants.topHeadlinesEndpoint,
        options: Options(headers: {'X-API-Key': NewsAppConstants.apiKey}),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['articles'] == null || data['articles'] is! List) {
          throw ParsingException(message: "Invalid response format");
        }

        final articlesJsonList = data['articles'] as List;
        return articlesJsonList
            .map((json) => NewsArticleModel.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message: "Request failed with status: ${response.statusCode}",
        );
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: "Connection timed out");
      } else if (dioError.type == DioExceptionType.badResponse) {
        throw ServerException(
          message:
              "Server error: ${dioError.response?.statusCode ?? 'unknown'}",
        );
      } else {
        throw NetworkException(message: "Network error: ${dioError.message}");
      }
    } on FormatException catch (e) {
      throw ParsingException(message: "Data format error: ${e.message}");
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
