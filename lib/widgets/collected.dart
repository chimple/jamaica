import 'package:flutter/material.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/collected_item_screen.dart';
import 'package:jamaica/models/collected_item_data.dart';

class Collected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     var items = StateContainer.of(context).state.userProfile.items;
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Store'),
        ),
        body: CollectedItemScreen(staticItems: list,itemsValue: items,));
  }
}
