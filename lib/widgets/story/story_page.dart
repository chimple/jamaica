import 'package:flutter/material.dart';
import 'package:jamaica/models/story_config.dart';

class StoryPage extends StatelessWidget {
  final List<Page> page;
  StoryPage({this.page});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        child: PageView.builder(
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Card(
                    child: Image.asset(
                      page[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 10, top: 20),
                    child: SingleChildScrollView(
                      child: Text(
                        page[index].text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            wordSpacing: 4.0,
                            letterSpacing: 2.0),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
          itemCount: page.length,
        ),
      ),
    );
  }
}
