import 'package:flutter/material.dart';
import 'package:jamaica/widgets/collected_item_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
             title: Text('Profile'),
            bottom: TabBar(
              tabs: [
                Text('Status'),
                Text('Collection'),
                Text('Store')
              ],
            ),
           
          ),
          body: TabBarView(
            children: [
               Text('Content1'),
               CollectedItemScreen(),
               Text('Content3')
            ],
          ),
        ),
      ),
    );
  }
}
