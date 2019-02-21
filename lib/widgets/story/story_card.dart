import 'package:flutter/material.dart';
import 'package:jamaica/models/story_config.dart';
import 'package:jamaica/widgets/story/story_page.dart';

class StoryCard extends StatelessWidget {
  final index;
  final StoryConfig storyModal;
  StoryCard({this.index, @required this.storyModal});
  Widget build(BuildContext context) {
    print('storyModal.coverImagePath ${storyModal.coverImagePath}');
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        print(storyModal.pages);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StoryPage(
                  pages: storyModal.pages,
                )));
      },
      child: new Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              storyModal.coverImagePath,
              fit: BoxFit.cover,
            ),
            Text(
              storyModal.title,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
