import 'package:dartz/dartz.dart';
import 'package:newsapp/core/errors/failure_errors.dart';
import 'package:newsapp/core/errors/exception_errors.dart';
import 'package:newsapp/features/NewsApp/data/data_sources/news_api_data_source.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/NewsApp/domain/repository/news_article_repository.dart';

class NewsArticleRepositoryImpl extends NewsArticleRepository {
  final NewsDataSource newsDataSource;

  NewsArticleRepositoryImpl({required this.newsDataSource});

  @override
  Future<Either<FailureError, List<NewsArticleEntity>>> getNewsArticles({
    int? page,
  }) async {
    try {
      final newsArticleModels = await newsDataSource.getNewsArticlesFromSource(
        page: page,
      );

      final newsArticleEntityList = newsArticleModels
          .map((model) => model.toEntity())
          .toList();

      return Right(newsArticleEntityList);
    } on ServerException catch (e) {
      return Left(ServerFailureError(e.message));
    } on NetworkException catch (e) {
      return Left(ConnectionFailureError(e.message));
    } on ParsingException catch (e) {
      return Left(ParsingFailureError(e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailureError(e.message));
    } catch (e) {
      return Left(UnknownFailureError("Unexpected error: $e"));
    }
  }
}
