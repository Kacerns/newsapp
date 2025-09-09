import 'package:dartz/dartz.dart';
import 'package:newsapp/core/errors/failure_errors.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

abstract class NewsArticleRepository {
  Future<Either<FailureError, List<NewsArticleEntity>>> getNewsArticles({
    int? page,
  });
}
