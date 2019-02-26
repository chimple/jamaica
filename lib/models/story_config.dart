import 'package:json_annotation/json_annotation.dart';

part 'story_config.g.dart';

@JsonSerializable()
class StoryConfig {
  String storyId;
  String coverImagePath;
  String title;
  List<Page> pages;
  StoryConfig({this.storyId, this.coverImagePath, this.title, this.pages});
  factory StoryConfig.fromJson(Map<String, dynamic> parsedJson) =>
      _$StoryConfigFromJson(parsedJson);
}

@JsonSerializable(includeIfNull: false)
class Page {
  String pageNumber;
  String imagePath;
  String text;
  Page({this.text, this.imagePath, this.pageNumber});
  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
}
