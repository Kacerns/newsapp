import 'package:flutter/material.dart';
import 'package:newsapp/core/constants/news_app_constants.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/NewsApp/presentation/widgets/open_url_dialogue_widget.dart';
import 'package:date_format/date_format.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsArticleEntity newsArticleEntity;

  const NewsDetailsScreen({super.key, required this.newsArticleEntity});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.sizeOf(context).height;
    double deviceWidth = MediaQuery.sizeOf(context).width;
    bool isPortrait = deviceHeight > deviceWidth;

    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      body: SafeArea(
        child: isPortrait
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildContent(
                  context,
                  deviceHeight,
                  deviceWidth,
                  isPortrait,
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildContent(
                  context,
                  deviceHeight,
                  deviceWidth,
                  isPortrait,
                ),
              ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () =>
            OpenUrlDialog.openWebview(context, newsArticleEntity.url),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Read More'), Icon(Icons.arrow_forward_sharp)],
        ),
      ),
    );
  }

  List<Widget> _buildContent(
    BuildContext context,
    double deviceHeight,
    double deviceWidth,
    bool isPortrait,
  ) {
    return [
      Expanded(
        flex: isPortrait ? 2 : 1,
        child: Image.network(
          newsArticleEntity.urlToImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
      ),

      Expanded(
        flex: isPortrait ? 3 : 2,
        child: Padding(
          padding: isPortrait
              ? EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.05,
                  vertical: deviceHeight * 0.01,
                )
              : EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      'By ${newsArticleEntity.author}',
                    ),
                  ),
                  Expanded(
                    child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      formatDate(
                        DateTime.parse(newsArticleEntity.publishedAt).toLocal(),
                        [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn],
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.03),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        newsArticleEntity.title,
                      ),
                      SizedBox(height: deviceHeight * 0.02),
                      Text(
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 5,
                        newsArticleEntity.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: deviceHeight * 0.02),
                      InkWell(
                        onTap: () => OpenUrlDialog.openUrl(
                          context,
                          newsArticleEntity.url,
                        ),
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: NewsAppColors.highContBlue,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                          newsArticleEntity.url,
                        ),
                      ),
                      InkWell(
                        onTap: () => OpenUrlDialog.openUrl(
                          context,
                          newsArticleEntity.url,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: NewsAppColors.highContBlue,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                            'View in Browser...',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
