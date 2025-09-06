import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel extends NewsArticleEntity {
  @JsonKey(defaultValue: 'Unknown Author')
  final String author;

  @JsonKey(defaultValue: 'No Title Available')
  final String title;

  @JsonKey(defaultValue: 'No description provided')
  final String description;

  @JsonKey(defaultValue: '')
  final String url;

  @JsonKey(defaultValue: '')
  final String urlToImage;

  @JsonKey(defaultValue: '')
  final String publishedAt;

  @JsonKey(defaultValue: '')
  final String content;

  const NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  }) : super(
         author: author,
         title: title,
         description: description,
         url: url,
         urlToImage: urlToImage,
         publishedAt: publishedAt,
         content: content,
       );

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);

  NewsArticleEntity toEntity() => NewsArticleEntity(
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );
}
