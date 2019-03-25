import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:data/data.dart';
import 'package:jamaica/widgets/story/audio_text_bold.dart';
import 'package:jamaica/widgets/story/show_dialog_mode.dart';

class StoryPage extends StatefulWidget {
  final BuiltList<Page> pages;
  final String title;
  StoryPage({Key key, @required this.pages, this.title}) : super(key: key);

  @override
  StoryPageState createState() {
    return new StoryPageState();
  }
}

class StoryPageState extends State<StoryPage> {
  bool _isPlaying = false;
  List<StoryMode> storyMode = [];
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: PageView.builder(
        // pageSnapping: false,
        controller: pageController,
        onPageChanged: (int index) {
          print(index);
        },
        scrollDirection: Axis.vertical,
        physics: _isPlaying ? NeverScrollableScrollPhysics() : ScrollPhysics(),
        itemBuilder: (context, index) {
          var d = widget.pages[index].imageItemsPosition;
          print('drag data :: ${d}');
          print('data:: ${widget.pages[index].highlightQuestion}');
          return AudioTextBold(
              imagePath: widget.pages[index].imagePath,
              audioFile: widget.pages[index].audioPath,
              fullText: widget.pages[index].text,
              pageNumber: widget.pages[index].pageNumber,
              pageSliding: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                  // pageController.jumpToPage(
                  //     int.parse(widget.pages[index].pageNumber) - 1);
                });
              });
        },
        itemCount: widget.pages.length,
      ),
    );
  }
}
