import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

abstract class NewsArticleRepository {
  Future<List<NewsArticleEntity>> getNewsArticles({String? category});
}
