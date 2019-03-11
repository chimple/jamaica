// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryConfig _$StoryConfigFromJson(Map<String, dynamic> json) {
  return StoryConfig(
      storyId: json['storyId'] as String,
      coverImagePath: json['coverImagePath'] as String,
      title: json['title'] as String,
      pages: (json['pages'] as List)
          ?.map((e) =>
              e == null ? null : Page.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$StoryConfigToJson(StoryConfig instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'coverImagePath': instance.coverImagePath,
      'title': instance.title,
      'pages': instance.pages
    };

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page(
      text: json['text'] as String,
      imagePath: json['imagePath'] as String,
      pageNumber: json['pageNumber'] as String,
      audioPath: json['audioPath'] as String);
}

Map<String, dynamic> _$PageToJson(Page instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pageNumber', instance.pageNumber);
  writeNotNull('imagePath', instance.imagePath);
  writeNotNull('text', instance.text);
  writeNotNull('audioPath', instance.audioPath);
  return val;
}
