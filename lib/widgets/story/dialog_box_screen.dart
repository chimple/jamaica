import 'package:flutter/material.dart';

class DialogBoxScreen {
  Widget textDescriptionDialog(
      BuildContext context, String text, String textDesciption) {
    print(';');
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
