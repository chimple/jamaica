import 'package:flutter/material.dart';
import 'package:jamaica/screens/user_progress.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Progress",
              ),
              Tab(
                text: "Collection",
              ),
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
