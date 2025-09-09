import 'package:flutter/material.dart';

class NewsAppConstants {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = '6616486c57f240988fd2dfddf0db863b';

  static const String topHeadlinesEndpoint = '/top-headlines';
}

class NewsAppColors {
  // Light theme
  static const Color highContBlue = Color(0xFF1F4FD8);
  static const Color whiteMain = Colors.white;
  static const Color whiteSmoke = Color(0xfff5f5F5);
  static const Color lightOnSurface = Color.fromARGB(255, 17, 24, 41);

  // Dark theme
  static const Color darkHighContBlue = Color.fromARGB(255, 83, 114, 201);
  static const Color darkWhite = Color(0xfff5f5F5);
  static const Color darkSurface = Color.fromARGB(255, 16, 18, 22);
}
