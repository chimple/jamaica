import 'package:flutter/material.dart';
import 'package:jamaica/models/story_config.dart';
import 'package:jamaica/widgets/story/story_page.dart';

class StoryCard extends StatelessWidget {
  final index;
  final StoryConfig storyConfig;
  StoryCard({this.index, @required this.storyConfig});
  Widget build(BuildContext context) {
    print('storyConfig.coverImagePath ${storyConfig}');
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        print(storyConfig.page);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StoryPage(
                  page: storyConfig.page,
                )));
      },
      child: new Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              storyConfig.coverImagePath,
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
