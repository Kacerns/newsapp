import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/news_bloc.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/news_event.dart';
import 'package:newsapp/features/NewsApp/presentation/bloc/news_state.dart';
import 'package:newsapp/features/NewsApp/presentation/widgets/article_card_widget.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsEmpty) {
            context.read<NewsBloc>().add(OnLoadNews());
            return const Center(child: Text('No news available.'));
          } else if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsBloc>().add(OnLoadNews());
              },
              child: ListView.builder(
                itemCount: state.newsArticleEntityList.length,
                itemBuilder: (context, index) {
                  final newsArticleEntity = state.newsArticleEntityList[index];
                  return ArticleCard(newsArticleEntity: newsArticleEntity);
                },
              ),
            );
          } else if (state is NewsArticleLoadError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
