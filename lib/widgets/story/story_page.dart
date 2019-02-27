import 'package:flutter/material.dart';
import 'package:jamaica/models/story_config.dart';
import 'package:jamaica/widgets/story/custom_editable_text.dart';

class StoryPage extends StatelessWidget {
  final List<Page> pages;
  StoryPage({this.pages});

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
                      pages[index].imagePath,
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
                      child: CustomEditableText(
                        controller: TextEditingController(
                          text: pages[index].text,
                        ),
                        cursorColor: Colors.green,
                        selectionColor: Colors.red,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            wordSpacing: 4.0,
                            color: Colors.black,
                            letterSpacing: 2.0),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
          itemCount: pages.length,
        ),
      ),
    );
  }
}
