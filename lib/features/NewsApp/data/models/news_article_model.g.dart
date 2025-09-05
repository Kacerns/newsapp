// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticleModel _$NewsArticleModelFromJson(Map<String, dynamic> json) =>
    NewsArticleModel(
      modelAuthor: json['modelAuthor'] as String? ?? 'Unknown Author',
      modelTitle: json['modelTitle'] as String? ?? 'No Title Available',
      modelDescription:
          json['modelDescription'] as String? ?? 'No description provided',
      modelUrl: json['modelUrl'] as String? ?? '',
      modelUrlToImage: json['modelUrlToImage'] as String? ?? '',
      modelPublishedAt: json['modelPublishedAt'] as String? ?? '',
      modelContent: json['modelContent'] as String? ?? '',
    );

Map<String, dynamic> _$NewsArticleModelToJson(NewsArticleModel instance) =>
    <String, dynamic>{
      'modelAuthor': instance.modelAuthor,
      'modelTitle': instance.modelTitle,
      'modelDescription': instance.modelDescription,
      'modelUrl': instance.modelUrl,
      'modelUrlToImage': instance.modelUrlToImage,
      'modelPublishedAt': instance.modelPublishedAt,
      'modelContent': instance.modelContent,
    };
