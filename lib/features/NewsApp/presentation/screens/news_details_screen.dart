import 'package:flutter/material.dart';
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
      body: isPortrait
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
              : EdgeInsets.only(
                  right: deviceWidth * 0.07,
                  left: deviceHeight * 0.05,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: Text('By ${newsArticleEntity.author}')),
                  Expanded(
                    child: Text(
                      formatDate(
                        DateTime.parse(newsArticleEntity.publishedAt).toLocal(),
                        [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn],
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(newsArticleEntity.title),
                      SizedBox(height: deviceHeight * 0.02),
                      Text(newsArticleEntity.description),
                      SizedBox(height: deviceHeight * 0.02),
                      InkWell(
                        onTap: () =>
                            OpenUrlDialog.show(context, newsArticleEntity.url),
                        child: Text(newsArticleEntity.url),
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
