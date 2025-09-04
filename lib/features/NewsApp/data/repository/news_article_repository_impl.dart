import 'package:newsapp/features/NewsApp/data/data_sources/news_api_data_source.dart';
import 'package:newsapp/features/NewsApp/domain/repository/news_article_repository.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

class NewsArticleRepositoryImpl extends NewsArticleRepository {
  final NewsDataSource newsDataSource;

  NewsArticleRepositoryImpl({required this.newsDataSource});

  @override
  Future<List<NewsArticleEntity>> getNewsArticles({String? category}) async {
    try {
      final newsArticleModels = await newsDataSource.getNewsArticlesFromSource(
        category: category,
      );
      return newsArticleModels
          .map((newsArticleModel) => newsArticleModel.toEntity())
          .toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
