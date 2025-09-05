import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/features/NewsApp/domain/entities/news_article_entity.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel extends NewsArticleEntity {
  @JsonKey(defaultValue: 'Unknown Author')
  final String modelAuthor;

  @JsonKey(defaultValue: 'No Title Available')
  final String modelTitle;

  @JsonKey(defaultValue: 'No description provided')
  final String modelDescription;

  @JsonKey(defaultValue: '')
  final String modelUrl;

  @JsonKey(defaultValue: '')
  final String modelUrlToImage;

  @JsonKey(defaultValue: '')
  final String modelPublishedAt;

  @JsonKey(defaultValue: '')
  final String modelContent;

  const NewsArticleModel({
    required this.modelAuthor,
    required this.modelTitle,
    required this.modelDescription,
    required this.modelUrl,
    required this.modelUrlToImage,
    required this.modelPublishedAt,
    required this.modelContent,
  }) : super(
         author: modelAuthor,
         title: modelTitle,
         description: modelDescription,
         url: modelUrl,
         urlToImage: modelUrlToImage,
         publishedAt: modelPublishedAt,
         content: modelContent,
       );

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);

  NewsArticleEntity toEntity() => NewsArticleEntity(
    author: modelAuthor,
    title: modelTitle,
    description: modelDescription,
    url: modelUrl,
    urlToImage: modelUrlToImage,
    publishedAt: modelPublishedAt,
    content: modelContent,
  );
}
