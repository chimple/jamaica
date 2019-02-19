import 'package:flutter/material.dart';
import 'package:jamaica/widgets/collected_item_screen.dart';
import 'package:jamaica/loca.dart';
import 'package:jamaica/screens/user_progress.dart';
import 'package:jamaica/widgets/parent_access.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          bottom: TabBar(
            tabs: [Text('Status'), Text('Collection'), Text('Store')],
          ),
        ),
        body: TabBarView(
          children: [
            Text('Content1'),
            CollectedItemScreen(),
            Text('Content3')
          ],
        ),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              new Tab(text: Loca.of(context).progress),
              new Tab(text: Loca.of(context).collection),
          
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            color: Colors.blueGrey,
          ),
          TabBarView(
            children: [
              UserProgress(),
              Center(child: Text("data")),
            ],
          ),
        ]),
      ),
    );
  }
}
