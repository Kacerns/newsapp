import 'dart:io';
import 'package:newsapp/core/errors/failure_errors.dart';
import 'package:newsapp/features/NewsApp/data/data_sources/news_api_data_source.dart';
import 'package:newsapp/features/NewsApp/domain/repository/news_article_repository.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

class NewsArticleRepositoryImpl extends NewsArticleRepository {
  final NewsDataSource newsDataSource;

  NewsArticleRepositoryImpl({required this.newsDataSource});

  @override
  Future<List<NewsArticleEntity>> getNewsArticles({int? page}) async {
    try {
      final newsArticleModels = await newsDataSource.getNewsArticlesFromSource(
        page: page,
      );
      List<NewsArticleEntity> newsArticleEntityList = newsArticleModels
          .map((newsArticleModel) => newsArticleModel.toEntity())
          .toList();
      return newsArticleEntityList;
    } on SocketException catch (e) {
      throw ConnectionFailureError('No internet connection: ${e.message}');
    } on HttpException catch (e) {
      throw ServerFailureError('Failed to fetch news: ${e.message}');
    } on FormatException catch (e) {
      throw ServerFailureError('Invalid response format: ${e.message}');
    } catch (e) {
      throw ServerFailureError('Unexpected error occurred: $e');
    }
  }
}
