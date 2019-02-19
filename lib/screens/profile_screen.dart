import 'package:flutter/material.dart';
import 'package:jamaica/widgets/collected.dart';
import 'package:jamaica/loca.dart';
import 'package:jamaica/screens/user_progress.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              Collected(),
            ],
          ),
        ]),
      ),
    );
    }
}
