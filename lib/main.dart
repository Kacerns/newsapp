import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/theme/theme.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/news_bloc.dart';
import 'package:newsapp/core/dependency_injection/injection.dart';
import 'package:newsapp/features/NewsApp/presentation/screens/news_list_screen.dart';

void main() {
  setupDependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<NewsBloc>(create: (_) => getIt<NewsBloc>())],
      child: MaterialApp(
        title: 'News App',
        theme: NewsAppTheme.lightTheme,
        home: NewsListScreen(),
      ),
    );
  }
}
