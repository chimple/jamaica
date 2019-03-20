import 'package:flutter/material.dart';
import 'package:data/data.dart';
import 'package:jamaica/widgets/story/story_page.dart';

class StoryCard extends StatelessWidget {
  final index;
  final StoryConfig storyConfig;
  StoryCard({this.index, @required this.storyConfig});
  Widget build(BuildContext context) {
    // print('storyConfig:: ${storyConfig}');
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        // print(storyConfig.pages);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StoryPage(
                  pages: storyConfig.pages,
                )));
      },
      child: new Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/stories/images/${storyConfig.coverImagePath}',
              fit: BoxFit.cover,
            ),
            Text(
              storyConfig.title,
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
