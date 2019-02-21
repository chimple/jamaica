import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () => Navigator.of(context).pushNamed('/profile'),
                ),
                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () => Navigator.of(context).pushNamed('/map'),
                ),
                IconButton(
                  icon: Icon(Icons.games),
                  onPressed: () => Navigator.of(context).pushNamed('/games'),
                ),
                IconButton(
                  icon: Icon(Icons.store),
                  onPressed: () => Navigator.of(context).pushNamed('/store'),
                ),
                IconButton(
                  icon: Icon(Icons.book),
                  onPressed: () => Navigator.of(context).pushNamed('/story'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
