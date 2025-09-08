import 'package:equatable/equatable.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<NewsArticleEntity> newsArticleEntityList;
  final int currentPage;
  final bool hasReachedMax;
  final bool nextPageLoad;

  const NewsLoaded({
    required this.newsArticleEntityList,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.nextPageLoad = false,
  });

  @override
  List<Object> get props => [
    newsArticleEntityList,
    currentPage,
    hasReachedMax,
    nextPageLoad,
  ];
}

class NewsArticleLoadError extends NewsState {
  final String message;

  const NewsArticleLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
