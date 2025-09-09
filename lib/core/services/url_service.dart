import 'package:flutter/material.dart';
import 'package:newsapp/core/errors/failure_errors.dart';
import 'package:newsapp/features/NewsApp/presentation/screens/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  UrlService();

  Future<void> openInWebView(BuildContext context, String url) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
    );
  }

  Future<void> openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri);
    } catch (e) {
      throw ConnectionFailureError(e.toString());
    }
  }
}
