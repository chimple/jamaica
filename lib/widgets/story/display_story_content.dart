import 'package:flutter/material.dart';
import 'dart:core';

class DisplayStoryContent extends StatelessWidget {
  int index;
  final List<String> listofWords;
  DisplayStoryContent({Key key, this.listofWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: listofWords.map((d) {
        return InkWell(
          splashColor: Colors.yellow,
          onLongPress: () {
            index = listofWords.indexOf(d);
            showDialog(
              context: context,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 0.5
                          : 0.8,
                  widthFactor:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 0.8
                          : 0.4,
                  child: _textDescriptionDialog(context, d,
                      "Hello This is the Description about the word that you just pressed and the word that you pressed is "),
                );
              },
            );
          },
          child: Text(d + " ",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  wordSpacing: 4.0,
                  letterSpacing: 2.0)),
        );
      }).toList(),
    );
  }

  Widget _textDescriptionDialog(
      BuildContext context, String text, String textDesciption) {
    text = text.replaceAll(new RegExp(r'[^\w\s]+'), '');
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: new IconButton(
                  icon: new Icon(Icons.volume_up),
                  iconSize: mediaQuery.size.height * 0.07,
                  color: Colors.black,
                  onPressed: () {}),
            ),
            Column(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                      fontSize: mediaQuery.size.height * 0.05,
                      color: Colors.green),
                ),
                Image.asset('assets/stories/images/$text.jpg',
                    height: mediaQuery.orientation == Orientation.portrait
                        ? mediaQuery.size.height * 0.2
                        : mediaQuery.size.height * 0.3),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    textDesciption + '$text',
                    style: TextStyle(
                        fontSize: mediaQuery.orientation == Orientation.portrait
                            ? mediaQuery.size.height * 0.02
                            : mediaQuery.size.height * 0.03,
                        color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
