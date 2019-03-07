import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/widgets/story/display_story_content.dart';

class AudioTextBold extends StatefulWidget {
  final String fullText;
  final Function pageSliding;
  final String audioFile;
  final String pageNumber;
  AudioTextBold(
      {Key key,
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
  int position;
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
  String start = "", middle = "", end = "", endLine = '';
  List<String> _audioFiles = [], listOfLines, words;
  final _regex = RegExp('[a-zA-Z0-9]');
  final _regex1 = RegExp('[!?,|]');
  int numOfChar, charTime, incr = 0, _countDots;

  List<String> temp = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioCache?.clearCache();
    audioPlayer?.stop();
    super.dispose();
  }

  Future pause() async {
    print('pause');
    await audioPlayer.pause().then((s) {});
    print(listOfWords);
    setState(() => isPause = true);
    widget.pageSliding();
  }

  Future resume() async {
    print('resume');
    await audioPlayer.resume();
    setState(() {
      isPause = false;
    });
    widget.pageSliding();
    looping(temp, temp.length);
  }

  play(String url) async {
    print('play');
    endLine = '';
    try {
      await audioCache.play('$url');
      audioPlayer.durationHandler = (d) {
        _duration = d.inMilliseconds;
        if (durationText > 0 && !isDurationZero) {
          for (int i = incr + 1; i < listOfLines.length; i++)
            endLine = endLine + listOfLines[i];
          print('end Line :: $endLine');
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
      print(state);
      if (state == AudioPlayerState.COMPLETED) {
        isDurationZero = false;
        incr++;
        if (incr == _audioFiles.length) {
          new Future.delayed(Duration(milliseconds: 1000), () {
            onComplete();
          });
        }

        _duration = 0;
        isDurationZero = false;
        new Future.delayed(Duration(milliseconds: 900), () {
          try {
            if (!isPause && mounted) play(_audioFiles[incr]);
          } catch (e) {
            print(e);
          }
        });

        print(incr);
      }
    };
  }

  List<String> listOfWords = [];
  void looper(String text, int time) async {
    listOfWords = text.split(" ");
    numOfChar = text.length;
    charTime = (time ~/ numOfChar);
    looping(listOfWords, listOfWords.length);
  }

  void looping(List<String> w, int l) async {
    String space = " ";
    for (int i = 0; i < l; i++) {
      // int time = middle.length * charTime;
      // print('time:: $time');

      if (mounted && !isPause)
        setState(() {
          start = start + middle;
          try {
            if (i == l - 1) space = '';
            middle = w.removeAt(0) + space;
            temp = w;
          } catch (c) {}
          end = "";
          // for (String t in w) end = end + t + " ";
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

  Future loadAudio(String text, String aduio) async {
    listOfLines = text.split(".");
    words = text.split(" ");
    for (int i = 0; i < listOfLines.length; i++)
      listOfLines[i] = listOfLines[i] + ".";
    String str;
    _countDots = '.'.allMatches(text).length;
    bool b = words[words.length - 1].contains(_regex1);
    if (b) _countDots = _countDots + 1;
    for (int i = 1; i <= _countDots; i++) {
      str = aduio + i.toString();
      _audioFiles.add('$str.m4a');
    }
    try {
      await audioCache.loadAll(_audioFiles).then((s) {
        play(_audioFiles[0]);
        setState(() {
          isPlaying = true;
          isPause = false;
          isAudioFileAvailableOrNot = false;
        });
        widget.pageSliding();
      }, onError: (e) {});
    } catch (e) {
      print('No auid File found $e');
      print(e);
      setState(() {
        isPlaying = false;
        isPause = true;
        isAudioFileAvailableOrNot = true;
      });
      showSnackbar();
    }
  }

  showSnackbar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content:
          Container(height: 20, child: Center(child: Text('No Audio file'))),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
      duration: Duration(seconds: 1),
    ));
  }

  void onComplete() {
    print('complete');
    boldTextComplete = true;
    incr = 0;
    duration = 0;
    isDurationZero = false;
    start = "";
    middle = "";
    end = "";
    setState(() {
      isPlaying = false;
      isPause = true;
    });
    widget.pageSliding();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // alignment: AlignmentDirectional.bottomCenter,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: isPlaying
                  ? RichText(
                      text: new TextSpan(
                        // style: Theme.of(context).textTheme.body2,
                        children: <TextSpan>[
                          new TextSpan(
                              text: start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.black,
                              )),
                          new TextSpan(
                              text: middle,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.red,
                              )),
                          new TextSpan(
                              text: end,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 23,
                              )),
                          new TextSpan(
                              text: endLine,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 23,
                              )),
                        ],
                      ),
                    )
                  : DisplayStoryContent(
                      listofWords: widget.fullText.split(' ')),
            ),
          ),
          InkWell(
            onTap: !isPlaying
                ? () {
                    print('playing ');
                    if (isAudioFileAvailableOrNot) showSnackbar();
                    loadAudio(widget.fullText, widget.audioFile);
                  }
                : () {
                    if (audioPlayer.state == AudioPlayerState.PAUSED) {
                      resume();
                    } else if (audioPlayer.state == AudioPlayerState.PLAYING)
                      pause();
                    else if (listOfWords.isEmpty) {
                      play(_audioFiles[incr]);
                      setState(() => isPause = false);
                    }
                  },
            child: Container(
              child: isPause ? Icon(Icons.play_arrow) : Icon(Icons.pause),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}

// class WithoutAudioText extends StatelessWidget {
//   final String text;
//   WithoutAudioText({this.text});
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//         text: TextSpan(style: Theme.of(context).textTheme.body2, children: [
//       TextSpan(text: text, style: TextStyle(fontSize: 20, wordSpacing: 2.0))
//     ]));
//   }
// }
