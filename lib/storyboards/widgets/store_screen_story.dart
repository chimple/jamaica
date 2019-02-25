import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/screens/store_screen.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/store.dart';
import 'package:storyboard/storyboard.dart';
import 'package:jamaica/models/accessories_data.dart';

class StoreScreenStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
              child: Store(BuiltMap<String, String>({'hat': 'hat1'}), list)),
        )
      ];
}
