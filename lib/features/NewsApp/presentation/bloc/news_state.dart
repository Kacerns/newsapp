import 'package:equatable/equatable.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticleEntity> newsArticleEntityList;

  const NewsLoaded({required this.newsArticleEntityList});

  @override
  List<Object> get props => [newsArticleEntityList];
}

class NewsArticleLoadError extends NewsState {
  final String message;

  const NewsArticleLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
