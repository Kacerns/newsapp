import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:newsapp/features/NewsApp/data/data_sources/news_api_data_source.dart';
import 'package:newsapp/features/NewsApp/data/repository/news_article_repository_impl.dart';
import 'package:newsapp/features/NewsApp/domain/repository/news_article_repository.dart';
import 'package:newsapp/features/NewsApp/domain/usecases/get_news_articles_use_case.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/news_bloc.dart';

final GetIt getIt = GetIt.instance;

setupDependencyInjection() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<NewsDataSource>(
    () => NewsDataSourceImpl(dio: getIt()),
  );

  getIt.registerLazySingleton<NewsArticleRepository>(
    () => NewsArticleRepositoryImpl(newsDataSource: getIt()),
  );

  getIt.registerLazySingleton<GetNewsArticlesUseCase>(
    () => GetNewsArticlesUseCase(newsArticleRepository: getIt()),
  );

  getIt.registerFactory(() => NewsBloc(getIt()));
}
