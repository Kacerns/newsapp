import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent * 0.95) {
                    if (!state.isHasReachedMax && !state.isNextPageLoading) {
                      context.read<NewsBloc>().add(OnLoadMoreNews());
                    }
                  }
                  return false;
                },
                child: ListView.builder(
                  key: const PageStorageKey<String>('newsList'),
                  itemCount: state.newsArticleEntityList.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.newsArticleEntityList.length) {
                      if (state.isNextPageLoading) {
                        return Container(
                          height: 150,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state.isHasReachedMax) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                },
                              ),
                              content: Text(
                                'You have reached the end of the available articles',
                              ),
                              duration: Duration(milliseconds: 3000),
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        });
                      }
                      return SizedBox.shrink();
                    }
                    final news = state.newsArticleEntityList[index];
                    return ArticleCard(newsArticleEntity: news);
                  },
                ),
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
