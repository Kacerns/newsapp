import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import 'package:newsapp/features/NewsApp/domain/usecases/get_news_articles_use_case.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsArticlesUseCase getNewsArticlesUseCase;

  NewsBloc(this.getNewsArticlesUseCase) : super(NewsEmpty()) {
    on<OnLoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final newsArticleEntityList = await getNewsArticlesUseCase.execute(
          page: 1,
        );
        emit(
          NewsLoaded(
            newsArticleEntityList: newsArticleEntityList,
            currentPage: 1,
            hasReachedMax: false,
          ),
        );
      } catch (e) {
        emit(NewsArticleLoadError(message: e.toString()));
      }
    });

    on<OnLoadMoreNews>((event, emit) async {
      final currentState = state;
      if (currentState is! NewsLoaded) return;
      if (currentState.hasReachedMax) {
        return;
      }
      if (currentState.nextPageLoad) {
        return;
      }

      emit(
        NewsLoaded(
          newsArticleEntityList: currentState.newsArticleEntityList,
          currentPage: currentState.currentPage,
          hasReachedMax: currentState.hasReachedMax,
          nextPageLoad: true,
        ),
      );

      try {
        final newArticles = await getNewsArticlesUseCase.execute(
          page: currentState.currentPage + 1,
        );

        final updatedArticles = List.of(currentState.newsArticleEntityList)
          ..addAll(newArticles);

        bool hasReachedMax = newArticles.isEmpty;

        emit(
          NewsLoaded(
            newsArticleEntityList: updatedArticles,
            currentPage: currentState.currentPage + 1,
            hasReachedMax: hasReachedMax,
            nextPageLoad: false,
          ),
        );
      } catch (e) {
        emit(NewsArticleLoadError(message: e.toString()));
      }
    });
  }
}
