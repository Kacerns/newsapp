import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/webview_loading/webview_loading_event.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/webview_loading/webview_loading_state.dart';

class WebViewLoadingBloc
    extends Bloc<WebViewLoadingEvent, WebViewLoadingState> {
  WebViewLoadingBloc() : super(WebViewLoading()) {
    on<WebViewStartedLoading>((event, emit) {
      emit(WebViewLoading());
    });

    on<WebViewFinishedLoading>((event, emit) {
      emit(WebViewLoaded());
    });

    on<WebViewErrorOccurred>((event, emit) {
      if (event.errorDescription != 'ERR_BLOCKED_BY_ORB') {
        emit(WebViewError(event.errorDescription));
      }
    });
  }
}
