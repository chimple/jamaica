import 'package:flutter/material.dart';
import 'package:jamaica/widgets/audio_widget.dart';
import 'package:jamaica/widgets/cute_button.dart';
import 'package:storyboard/storyboard.dart';

class CuteButtonStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: CuteButton(
                        child: Center(child: Text('Success Success')),
                        reaction: Reaction.success,
                        onPressed: () {
                          print('Success Success Pressed');
                          return Reaction.success;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: CuteButton(
                        child: Center(child: Text('Success Failure')),
                        reaction: Reaction.success,
                        onPressed: () {
                          print('Success Failure Pressed');
                          return Reaction.failure;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: CuteButton(
                        child: Center(child: Text('Failure Failure')),
                        reaction: Reaction.failure,
                        onPressed: () {
                          print('Failure Failure Pressed');
                          return Reaction.failure;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: CuteButton(
                        child: Center(child: Text('Failure Success')),
                        reaction: Reaction.failure,
                        onPressed: () {
                          print('Failure Success Pressed');
                          return Reaction.success;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          body: SafeArea(
              child: Center(
            child: SizedBox(
              width: 256,
              height: 256,
              child: CuteButton(
                child: Center(child: Text('Success')),
                reaction: Reaction.success,
                onPressed: () {
                  print('Success Pressed');
                  return Reaction.success;
                },
              ),
            ),
          )),
        )
      ];
}
