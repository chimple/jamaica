import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamaica/models/story_modal.dart';
import 'package:jamaica/widgets/story/story_card.dart';

class StoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoryListState();
  }
}

class StoryListState extends State<StoryList> {
  List<StoryModal> _storyList = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadStory().then((s) {
      _storyList = s;
    });
  }

  Future<String> _loadStroyAsset() async {
    return await rootBundle.loadString('assets/stories/story.json');
  }

  Future<List<StoryModal>> _loadStory() async {
    String jsonString = await _loadStroyAsset();
    var jsonResponse = (json.decode(jsonString) as List);
    var list = jsonResponse
        .map<StoryModal>((data) => StoryModal.fromJson(data))
        .toList();
    setState(() {
      _isLoading = false;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        child: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return new Container(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return StoryCard(storyModal: _storyList[index]);
        },
        itemCount: _storyList.length,
      ),
    );
  }
}
