class StoryModal {
  String storyId;
  String coverImagePath;
  String title;
  List<Pages> pages;
  StoryModal({this.storyId, this.coverImagePath, this.title, this.pages});
  factory StoryModal.fromJson(Map<String, dynamic> parsedJson) {
    final page =
        parsedJson["pages"].map<Pages>((j) => Pages.fromJson(j)).toList();
    return StoryModal(
        storyId: parsedJson["story_id"],
        coverImagePath: parsedJson["cover_image_path"],
        title: parsedJson["title"],
        pages: page);
  }
}

class Pages {
  String pageNumber;
  String imagePath;
  String text;
  Pages({this.text, this.imagePath, this.pageNumber});
  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
        pageNumber: json["page_number"],
        imagePath: json["image_path"],
        text: json["text"]);
  }
}
