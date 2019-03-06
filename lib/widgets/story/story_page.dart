import 'package:flutter/material.dart';
import 'package:jamaica/models/story_config.dart';
import 'package:jamaica/widgets/story/audio_text_bold.dart';
import 'package:jamaica/widgets/story/display_story_content.dart';

class StoryPage extends StatefulWidget {
  final List<Page> pages;

  StoryPage({Key key, this.pages}) : super(key: key);

  @override
  StoryPageState createState() {
    return new StoryPageState();
  }
}

class StoryPageState extends State<StoryPage> {
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        child: PageView.builder(
          physics:
              _isPlaying ? NeverScrollableScrollPhysics() : ScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Card(
                    child: Image.asset(
                      widget.pages[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: AudioTextBold(
                      audioFile: widget.pages[index].audioPath,
                      fullText: widget.pages[index].text,
                      pageNumber: widget.pages[index].pageNumber,
                      pageSliding: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      }),
                )
              ],
            );
          },
          itemCount: widget.pages.length,
        ),
      ),
    );
  }
}
