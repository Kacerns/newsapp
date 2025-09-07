import 'package:flutter/material.dart';
import 'package:newsapp/core/dependency_injection/injection.dart';
import 'package:newsapp/core/services/url_service.dart';

class OpenUrlDialog extends StatelessWidget {
  final String url;

  const OpenUrlDialog({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final urlService = getIt<UrlService>();

    return AlertDialog(
      title: Text('Open URL'),
      content: Text('How would you like to open this URL?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            urlService.openInWebView(context, url);
          },
          child: Text('WebView'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            urlService.openInBrowser(url);
          },
          child: Text('Browser'),
        ),
      ],
    );
  }

  static Future<void> show(BuildContext context, String url) async {
    return showDialog(
      context: context,
      builder: (context) => OpenUrlDialog(url: url),
    );
  }
}
