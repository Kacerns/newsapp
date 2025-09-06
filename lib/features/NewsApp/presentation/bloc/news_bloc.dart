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
        final newsArticleEntityList = await getNewsArticlesUseCase.execute();
        emit(NewsLoaded(newsArticleEntityList: newsArticleEntityList));
      } catch (e) {
        emit(NewsArticleLoadError(message: e.toString()));
      }
    });
  }
}
