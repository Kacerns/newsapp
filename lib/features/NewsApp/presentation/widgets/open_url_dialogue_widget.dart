import 'package:flutter/material.dart';
import 'package:newsapp/core/dependency_injection/injection.dart';
import 'package:newsapp/core/errors/exception_errors.dart';
import 'package:newsapp/core/services/url_service.dart';

class OpenUrlDialog extends StatelessWidget {
  final String url;

  const OpenUrlDialog({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Open URL'),
      content: Text('How would you like to open this URL?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            openWebview(context, url);
          },
          child: Text('WebView'),
        ),
        TextButton(
          onPressed: () {
            openUrl(context, url);
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

  static Future<void> openWebview(BuildContext context, String url) async {
    final urlService = getIt<UrlService>();
    return urlService.openInWebView(context, url);
  }

  static Future<void> openUrl(BuildContext context, String url) async {
    final urlService = getIt<UrlService>();
    try {
      return urlService.openInBrowser(url);
    } on UnknownException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
          content: Text('Unexpected error: {$e.toString()}'),
          duration: Duration(milliseconds: 3000),
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
    }
  }
}
