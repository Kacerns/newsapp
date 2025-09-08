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
          onWebResourceError: (WebResourceError error) {
            context.read<WebViewLoadingBloc>().add(
              WebViewErrorOccurred(error.description),
            );
          },
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
          if (state is WebViewLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WebViewError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48),
                SizedBox(height: 12),
                Text('Oops! ${state.message}', textAlign: TextAlign.center),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<WebViewLoadingBloc>().add(
                      WebViewStartedLoading(),
                    );
                    webViewController.loadRequest(Uri.parse(url));
                  },
                  child: Text('Retry'),
                ),
              ],
            );
          }
          return WebViewWidget(controller: webViewController);
        },
      ),
    );
  }
}
