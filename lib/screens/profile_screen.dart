import 'package:flutter/material.dart';
import 'package:jamaica/widgets/parent_access.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: IconButton(
            iconSize: 50.0,
            color: Colors.black,
            icon: new Icon(Icons.announcement),
            tooltip: 'for parents',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 0.5
                        : 0.8,
                    widthFactor: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 0.8
                        : 0.4,
                    child: ParentAccess(),
                  );
                },
              );
            },
          ),
        ));
  }
}
