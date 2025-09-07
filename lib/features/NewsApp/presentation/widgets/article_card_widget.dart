import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';
import 'package:newsapp/features/NewsApp/presentation/screens/news_details_screen.dart';

class ArticleCard extends StatelessWidget {
  final NewsArticleEntity newsArticleEntity;
  late final String? image;
  late final String title;
  late final String description;
  late final String publishedAt;

  ArticleCard({super.key, required this.newsArticleEntity}) {
    image = newsArticleEntity.urlToImage;
    title = newsArticleEntity.title;
    description = newsArticleEntity.description;
    publishedAt = newsArticleEntity.publishedAt;
  }

  String getTimeDifference() {
    var currentTime = DateTime.now();
    var publishedTime = DateTime.parse(publishedAt).toLocal();
    var difference = currentTime.difference(publishedTime);

    if (difference.inMinutes < 60) {
      return difference.inMinutes <= 5
          ? 'Just now'
          : '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return difference.inHours == 1
          ? '${difference.inHours} hour ago'
          : '${difference.inHours} hours ago';
    } else {
      return difference.inDays == 1
          ? '${difference.inDays} day ago'
          : '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.sizeOf(context).height;
    double deviceWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewsDetailsScreen(newsArticleEntity: newsArticleEntity),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.03,
          vertical: deviceHeight * 0.01,
        ),
        child: Container(
          height: deviceHeight >= deviceWidth
              ? deviceHeight * 0.25
              : deviceHeight * 0.5,
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.03,
            vertical: deviceHeight * 0.015,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: AutoSizeText(
                                title,
                                maxLines: 4,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Expanded(
                              child: Text(
                                description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.03,
                        ),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text(getTimeDifference())],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
