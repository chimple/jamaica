import 'package:flutter/material.dart';
import 'package:jamaica/widgets/theme_map.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: ThemeMap());
  }
}
