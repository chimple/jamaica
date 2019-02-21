import 'package:json_annotation/json_annotation.dart';

part 'story_config.g.dart';

@JsonSerializable()
class StoryConfig {
  String storyId;
  String coverImagePath;
  String title;
  List<Pages> pages;
  StoryConfig({this.storyId, this.coverImagePath, this.title, this.pages});
  factory StoryConfig.fromJson(Map<String, dynamic> parsedJson) =>
      _$StoryConfigFromJson(parsedJson);
}

@JsonSerializable(includeIfNull: false)
class Pages {
  String pageNumber;
  String imagePath;
  String text;
  Pages({this.text, this.imagePath, this.pageNumber});
  factory Pages.fromJson(Map<String, dynamic> json) => _$PagesFromJson(json);
}
