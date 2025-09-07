// webview_loading_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/webview_loading/webview_loading_bloc.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/webview_loading/webview_loading_event.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/webview_loading/webview_loading_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebViewLoadingBloc(),
      child: WebViewContent(url: url),
    );
  }
}

class WebViewContent extends StatelessWidget {
  final String url;

  const WebViewContent({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            context.read<WebViewLoadingBloc>().add(WebViewStartedLoading());
          },
          onPageFinished: (String url) {
            context.read<WebViewLoadingBloc>().add(WebViewFinishedLoading());
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title: Text(Uri.parse(url).host)),
      body: BlocBuilder<WebViewLoadingBloc, WebViewLoadingState>(
        builder: (context, state) {
          return Stack(
            children: [
              WebViewWidget(controller: webViewController),
              if (state is WebViewLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
