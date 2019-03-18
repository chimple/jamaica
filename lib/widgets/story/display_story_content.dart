import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jamaica/widgets/story/custom_editable_text.dart';
import 'package:jamaica/widgets/story/dialog_box_screen.dart';
import 'package:jamaica/widgets/story/selectable_text.dart';

enum StoryOption { showDialog, highlighter, dragText }

class DisplayStoryContent extends StatefulWidget {
  final Function pageSliding;
  final List<String> listofWords;
  DisplayStoryContent({Key key, this.listofWords, this.pageSliding})
      : super(key: key);

  @override
  _DisplayStoryContentState createState() => _DisplayStoryContentState();
}

class _DisplayStoryContentState extends State<DisplayStoryContent> {
  List<int> _highlighterColor = [];
  static String color = '';
  bool isDragging = false, isDragging1 = false;
  int _lastIndex = -1;
  double initial, distance;
  StoryOption storyOption;
  int _baseOffset = 0;
  bool highlightOnLongPress = false;
  @override
  void initState() {
    super.initState();
  }

  void _startOffset(TextSelection t) {
    _baseOffset = t.base.offset;
  }

  void _updateOffset(int extendOffset) {
    if (_baseOffset < extendOffset)
      setState(() {
        _middleSubString =
            widget.listofWords.join(' ').substring(_baseOffset, extendOffset);
        _startSubString =
            widget.listofWords.join(' ').substring(0, _baseOffset);
        _endSubString = widget.listofWords
            .join(' ')
            .substring(extendOffset, widget.listofWords.join(' ').length);
      });
  }

  String _startSubString = '', _middleSubString = '', _endSubString = '';
  int highlightIndex = -1;
  @override
  Widget build(BuildContext context) {
    int index = 0;
    Widget _build(String s, int i) {
      return InkWell(
        onLongPress: () {
          setState(() {
            highlightIndex = i;
          });
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
                  child: DialogBoxScreen()
                      .textDescriptionDialog(context, s, 'textDesciption'));
            },
          );
        },
        child: Container(
          color: highlightIndex == i ? Colors.red : Colors.transparent,
          child: Text(
            s + ' ',
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    if (storyOption != StoryOption.highlighter)
      return Stack(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: _startSubString,
                    style: TextStyle(fontSize: 23, color: Colors.transparent)),
                TextSpan(
                    text: _middleSubString,
                    style: TextStyle(
                        fontSize: 23,
                        background: Paint()..color = Colors.red,
                        color: Colors.transparent)),
                TextSpan(
                    text: _endSubString,
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: 23,
                    ))
              ],
            ),
          ),
          CustomEditableText(
              controller: CustomTextEditingController(
                  text: widget.listofWords.join(' ')),
              focusNode: FocusNode(),
              cursorColor: Colors.transparent,
              style: TextStyle(color: Colors.black, fontSize: 23),
              backgroundCursorColor: Colors.red,
              enableInteractiveSelection: true,
              maxLines: null,
              dragStartBehavior: DragStartBehavior.start,
              paintCursorAboveText: true,
              autocorrect: true,
              startOffset: (s) => _startOffset(s),
              updateOffset: (o) => _updateOffset(o.extentOffset),
              draEnd: (t) {
                _baseOffset = t.base.offset;
                _updateOffset(t.extent.offset);
              },
              onLongPress: (s, textSelection) {
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return FractionallySizedBox(
                //         heightFactor: MediaQuery.of(context).orientation ==
                //                 Orientation.portrait
                //             ? 0.5
                //             : 0.8,
                //         widthFactor: MediaQuery.of(context).orientation ==
                //                 Orientation.portrait
                //             ? 0.8
                //             : 0.4,
                //         child: DialogBoxScreen().textDescriptionDialog(
                //             context, s, 'textDesciption'));
                //   },
                // );
                // _baseOffset = textSelection.base.offset;
                // _updateOffset(textSelection.extentOffset);
              }),
        ],
      );
    else
      return Wrap(
        children: widget.listofWords.map((s) => _build(s, index++)).toList(),
      );
  }
}
