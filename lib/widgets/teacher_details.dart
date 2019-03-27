import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/models/class_session.dart';
import 'package:data/models/serializers.dart';
import 'package:flutter/material.dart';

class TeacherDetails extends StatelessWidget {
  final dynamic teacher;

  const TeacherDetails(this.teacher, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final standardSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    final newJson = jsonDecode(teacher['endPointName']);
    ClassSession classSession = standardSerializers.deserialize(newJson);

    MediaQueryData media = MediaQuery.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    var size = media.size;
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
      ),
      margin: EdgeInsets.all(size.width * .02),
      child: new Stack(
        children: <Widget>[
          Container(
            width: size.width * .25,
            height: orientation == Orientation.portrait
                ? size.height * .15
                : size.height * .35,
            child: Column(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(50.0)),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/stories/images/${classSession.teacherPhoto}'),
                      )),
                  width: orientation == Orientation.portrait
                      ? size.width * 0.2
                      : size.width * 0.12,
                  height: orientation == Orientation.portrait
                      ? size.height * .1
                      : size.height * .2,
                ),
                new Container(
                    child: new Text(classSession.teacherName,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: new TextStyle(
                            fontSize: orientation == Orientation.portrait
                                ? size.height * .02
                                : size.height * .05,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis)),
                new Container(
                    child: new Text(classSession.name,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: new TextStyle(
                            fontSize: orientation == Orientation.portrait
                                ? size.height * .015
                                : size.height * .03,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
