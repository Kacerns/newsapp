import 'package:dartz/dartz.dart';
import 'package:newsapp/core/errors/failure_errors.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/NewsApp/domain/repository/news_article_repository.dart';

class GetNewsArticlesUseCase {
  final NewsArticleRepository newsArticleRepository;

  GetNewsArticlesUseCase({required this.newsArticleRepository});

  Future<Either<FailureError, List<NewsArticleEntity>>> execute({int? page}) {
    return newsArticleRepository.getNewsArticles(page: page ?? 1);
  }
}
