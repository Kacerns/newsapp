import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import 'package:newsapp/features/NewsApp/domain/usecases/get_news_articles_use_case.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsArticlesUseCase getNewsArticlesUseCase;

  NewsBloc(this.getNewsArticlesUseCase) : super(NewsEmpty()) {
    on<OnLoadNews>((event, emit) async {
      emit(NewsLoading());
      final newsArticleEntityList = await getNewsArticlesUseCase.execute(
        page: 1,
      );
      newsArticleEntityList.fold(
        (failureError) {
          emit(NewsArticleLoadError(message: failureError.message));
        },
        (newsArticleEntityList) {
          emit(
            NewsLoaded(
              newsArticleEntityList: newsArticleEntityList,
              currentPage: 1,
              isHasReachedMax: false,
            ),
          );
        },
      );
    });

    on<OnLoadMoreNews>((event, emit) async {
      final currentState = state;
      if (currentState is! NewsLoaded ||
          currentState.isHasReachedMax ||
          currentState.isNextPageLoading) {
        return;
      }

      emit(
        NewsLoaded(
          newsArticleEntityList: currentState.newsArticleEntityList,
          currentPage: currentState.currentPage,
          isHasReachedMax: currentState.isHasReachedMax,
          isNextPageLoading: true,
        ),
      );

      final newArticles = await getNewsArticlesUseCase.execute(
        page: currentState.currentPage + 1,
      );

      newArticles.fold(
        (failureError) {
          emit(NewsArticleLoadError(message: failureError.message));
        },
        (newsArticleEntityList) {
          final updatedArticles = List.of(currentState.newsArticleEntityList)
            ..addAll(newsArticleEntityList);

          bool isHasReachedMax = newsArticleEntityList.isEmpty;

          emit(
            NewsLoaded(
              newsArticleEntityList: updatedArticles,
              currentPage: currentState.currentPage + 1,
              isHasReachedMax: isHasReachedMax,
              isNextPageLoading: false,
            ),
          );
        },
      );
    });
  }
}
