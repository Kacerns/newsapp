import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/NewsApp/domain/repository/news_article_repository.dart';

class GetNewsArticlesUseCase {
  final NewsArticleRepository newsArticleRepository;

  GetNewsArticlesUseCase({required this.newsArticleRepository});

  Future<List<NewsArticleEntity>> execute({int? page}) {
    Future<List<NewsArticleEntity>> newsArticleEntityList =
        newsArticleRepository.getNewsArticles(page: page ?? 1);
    return newsArticleEntityList;
  }
}
