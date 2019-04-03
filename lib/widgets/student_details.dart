import 'dart:io';

import 'package:data/data.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final Student studentDetails;

  const StudentDetails(this.studentDetails, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    var size = media.size;
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(studentDetails.photo),
          maxRadius: 50.0,
        ),
        Text(studentDetails.name,
            style: TextStyle(
                fontSize: orientation == Orientation.portrait
                    ? size.height * .02
                    : size.height * .05,
                color: Colors.white),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
