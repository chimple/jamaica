import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamaica/models/story_config.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/story/story_card.dart';

class StoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoryListState();
  }
}

class StoryListState extends State<StoryList> {
  // List<StoryConfig> _storyList = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadStory().then((s) {
      // _storyList = s;
    });
  }

  Future<String> _loadStoryAsset() async {
    return await rootBundle.loadString('assets/stories/story.json');
  }

  Future _loadStory() async {
    String jsonString = await _loadStoryAsset();
    var jsonResponse = (json.decode(jsonString) as List);
    var list = jsonResponse
        .map<StoryConfig>((data) => StoryConfig.fromJson(data))
        .toList();
    StateContainer.of(context).loadStoryData(list);
    setState(() {
      _isLoading = false;
    });
    // return list;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading &&
        StateContainer.of(context).state.userProfile.storyList == null) {
      return Container(
        child: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      final stateContainer =
          StateContainer.of(context).state.userProfile.storyList;
      return new Container(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return StoryCard(storyModal: stateContainer[index]);
          },
          itemCount: stateContainer.length,
        ),
      );
    }
  }
}
