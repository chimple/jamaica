import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/widgets/story/show_dialog_mode.dart';
import 'package:jamaica/widgets/story/text_highlighter.dart';

class AudioTextBold extends StatefulWidget {
  final String fullText;
  final Function pageSliding;
  final String audioFile;
  final String pageNumber;
  final StoryMode storyMode;
  AudioTextBold(
      {Key key,
      this.storyMode,
      this.fullText,
      this.pageSliding,
      this.audioFile,
      this.pageNumber})
      : super(key: key);
  @override
  _TextAudioState createState() => new _TextAudioState();
}

class _TextAudioState extends State<AudioTextBold> {
  int duration;
  set _duration(int d) => duration = d;
  int get durationText => duration != null ? duration : 0;
  static AudioPlayer audioPlayer = new AudioPlayer();
  final AudioCache audioCache =
      new AudioCache(prefix: 'stories/story_audio/', fixedPlayer: audioPlayer);
  bool isPlaying = false,
      isDurationZero = false,
      boldTextComplete = false,
      isPause = true,
      isAudioFileAvailableOrNot = false;
  String start = "", middle = "", end = "", endLine = '', firstLine = '';
  List<String> _audioFiles = [], listOfLines = [], words;
  final _regex = RegExp('[a-zA-Z0-9]');
  final _regex1 = RegExp('[!?,|]');
  int numOfChar, charTime, incr = 0, _count;
  List<String> temp = [];
  StoryMode storyMode = StoryMode.textMode;
  @override
  void dispose() {
    audioCache?.clearCache();
    audioPlayer?.stop();
    super.dispose();
  }

  Future pause() async {
    print('pause');
    await audioPlayer.pause().then((s) {
      setState(() => isPause = true);
      _duration = 0;
      isDurationZero = false;
    });
    widget.pageSliding();
  }

  Future resume() async {
    print('resume');
    reset();
    await audioPlayer.release();
    play(_audioFiles[incr]).then((s) {
      setState(() {
        isPause = false;
      });
    });
    print('audio status ${audioPlayer.state}');
    widget.pageSliding();
  }

  void reset() {
    endLine = '';
    firstLine = '';
    for (int i = incr + 1; i < listOfLines.length; i++) {
      endLine = endLine + listOfLines[i];
    }
    print('end line:: $endLine');
    for (int i = 0; i < incr; i++) {
      print('start line:: ${listOfLines[i]}');
      firstLine = firstLine + listOfLines[i];
    }
    setState(() {});
  }

  play(String url) async {
    print('play');
    reset();
    try {
      await audioCache.play('$url');
      audioPlayer.durationHandler = (d) {
        _duration = d.inMilliseconds;
        if (durationText > 0 && !isDurationZero) {
          looper(listOfLines[incr], durationText);
          isDurationZero = true;
        }
      };
      if (isPlaying) {
        playNext();
      }
    } catch (e) {}
  }

  playNext() async {
    audioPlayer.audioPlayerStateChangeHandler = (state) {
      if (state == AudioPlayerState.COMPLETED) {
        isDurationZero = false;
        incr++;
        // lastString = listOfLines[incr];
        print(incr);
        if (incr == _audioFiles.length) {
          new Future.delayed(Duration(milliseconds: 1000), () {
            onComplete();
          });
        }

        lastAudioFile = _audioFiles[incr];
        _duration = 0;
        isDurationZero = false;
        if (incr != _audioFiles.length)
          new Future.delayed(Duration(milliseconds: 900), () {
            try {
              if (!isPause && mounted) play(_audioFiles[incr]);
            } catch (e) {
              print(e);
            }
          });
      }
    };
  }

  String lastString, lastAudioFile;
  void looper(String text, int time) async {
    start = '';
    middle = '';
    end = '';
    print(text);
    List<String> listOfWords = [];
    lastString = text;
    listOfWords = text.split(" ");
    numOfChar = text.length;
    charTime = (time ~/ numOfChar);
    looping(listOfWords, listOfWords.length);
  }

  void looping(List<String> w, int l) async {
    String space = " ";

    for (int i = 0; i < l - 1; i++) {
      if (mounted && !isPause)
        setState(() {
          start = start + middle;
          try {
            if (i == l - 1) space = '';
            middle = w.removeAt(0) + space;
            print(w);
            temp = w;
          } catch (c) {}
          end = "";
          end = w.join(" ");
        });
      await Future.delayed(
          Duration(milliseconds: (isPause) ? 0 : middle.length * charTime));
      if (audioPlayer.state == AudioPlayerState.PAUSED) break;
    }
  }

  int checkSpecialChar(String middle) {
    int time = middle.length * charTime;
    String s = middle.substring(0, 1);
    if (mounted) {
      bool c = s.contains(_regex);
      if (!c) time = 0;
    }
    return time;
  }

  Future loadAudio(String text, String audio) async {
    String string = '';
    words = text.split(" ");
    listOfLines?.clear();
    _audioFiles?.clear();
    for (int i = 0; i < words.length; i++) {
      string = string + words[i] + ' ';
      if (words[i].contains(RegExp('[!.]'))) {
        listOfLines.add(string);
        string = '';
      }
    }

    // for (int i = 0; i < listOfLines.length; i++)
    //   listOfLines[i] = listOfLines[i] + ".";
    String str;
    _count = '.'.allMatches(text).length + '!'.allMatches(text).length;
    // bool b = words[words.length - 1].contains(_regex1);
    // print(_count);
    // if (b) _count = _count + 1;
    for (int i = 1; i <= _count; i++) {
      str = audio + i.toString();
      _audioFiles.add('$str.m4a');
    }

    try {
      await audioCache.loadAll(_audioFiles).then((s) {
        lastAudioFile = _audioFiles[0];
        play(_audioFiles[0]);
        setState(() {
          isPlaying = true;
          isPause = false;
          storyMode = StoryMode.audioBoldTextMode;
          isAudioFileAvailableOrNot = false;
        });
        widget.pageSliding();
      }, onError: (e) {
        setState(() {
          isPlaying = false;
          isPause = true;
          isAudioFileAvailableOrNot = true;
        });
        showSnackbar(e.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  showSnackbar(String s) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Container(height: 20, child: Center(child: Text(s))),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
      duration: Duration(seconds: 1),
    ));
  }

  void onComplete() {
    print('completed');
    setState(() {
      isPlaying = false;
      isPause = true;
      start = "";
      middle = "";
      end = "";
      boldTextComplete = true;
      incr = 0;
      duration = 0;
      isDurationZero = false;
      endLine = '';
      storyMode = StoryMode.showDialogOnLongPressMode;
    });
    widget.pageSliding();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
                controller: ScrollController(), child: _build()),
          ),
          storyMode != StoryMode.textHighlighterMode
              ? InkWell(
                  onTap: !isPlaying
                      ? () {
                          loadAudio(widget.fullText, widget.audioFile);
                        }
                      : () {
                          print(audioPlayer.state);
                          if (audioPlayer.state == AudioPlayerState.PAUSED ||
                              audioPlayer.state == AudioPlayerState.COMPLETED) {
                            resume();
                          } else if (audioPlayer.state ==
                              AudioPlayerState.PLAYING) pause();
                          // else if (listOfWords.isEmpty ||
                          //     audioPlayer.state == AudioPlayerState.COMPLETED) {
                          //   play(_audioFiles[incr]);
                          //   setState(() => isPause = false);
                          // }
                        },
                  child: Container(
                    child: isPause ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _build() {
    if (storyMode == StoryMode.textMode)
      return TextMode(
        text: widget.fullText,
      );
    else if (storyMode == StoryMode.audioBoldTextMode) {
      return RichText(
        text: new TextSpan(
          children: <TextSpan>[
            new TextSpan(
                text: firstLine,
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                )),
            new TextSpan(
                text: start,
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                )),
            new TextSpan(
                text: middle,
                style: new TextStyle(
                  fontSize: 23,
                  color: Colors.red,
                )),
            new TextSpan(
                text: end,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                )),
            new TextSpan(
                text: endLine,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                )),
          ],
        ),
      );
    } else if (storyMode == StoryMode.textHighlighterMode)
      return TextHighlighter(
        text: widget.fullText,
      );
    else if (storyMode == StoryMode.showDialogOnLongPressMode)
      return ShowDialogMode(
        listofWords: widget.fullText.split(' '),
      );
    else
      return Container();
  }
}

class TextMode extends StatelessWidget {
  final String text;
  TextMode({this.text});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text, style: TextStyle(fontSize: 23, color: Colors.black)),
    );
  }
}
