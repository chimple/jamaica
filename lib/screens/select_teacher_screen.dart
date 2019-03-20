import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/models/class_session.dart';
import 'package:data/models/serializers.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/screens/select_student_screen.dart';
import 'package:jamaica/state/state_container.dart';

class SelectTeacherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TeachersScreen(advertisers: StateContainer.of(context).advertisers);
  }
}

class TeachersScreen extends StatefulWidget {
  final List<dynamic> advertisers;
  TeachersScreen({Key key, this.advertisers}) : super(key: key);
  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  String selected;
  dynamic selectedTeacher;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    MediaQueryData media = MediaQuery.of(context);
    return SafeArea(
          child: Scaffold(
          backgroundColor: Colors.orange,
          key: _scaffoldKey,
          body: Column(
            children: <Widget>[
              Container(
                height: media.size.height * .08,
                child: Center(
                  child: Center(
                    child: Text(
                      "Choose your Class",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  color: Colors.white70,
                  width: media.size.width * .9,
                  height: media.size.height * .004,
                ),
              ),
              Container(
                height: orientation == Orientation.portrait
                    ? media.size.height * .8
                    : media.size.height * .75,
                width: media.size.width,
                child: new GridView.count(
                  key: new Key('teacher_list'),
                  primary: true,
                  crossAxisCount: 4,
                  childAspectRatio: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height/1.4)
                      : MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height * 1.6),
                  // StateContainer.of(context).advertisers
                  children: widget.advertisers
                      .map((advertiser) => InkWell(
                          onTap: () {
                            setState(() {
                              selected = advertiser['endPointName'];
                              selectedTeacher = advertiser;
                            });
                          },
                          child: TeacherDetails(advertiser, selected)))
                      .toList(growable: false),
                ),
              ),
              Container(
                height: orientation == Orientation.portrait
                    ? media.size.height * .06
                    : media.size.height * .08,
                width: media.size.width * .2,
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if (selectedTeacher != null) {
                        setState(() {
                          loading = true;
                        });
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          content: new Row(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("  Processing...")
                            ],
                          ),
                        ));
                        await StateContainer.of(context)
                            .connectTo(selectedTeacher, () {
                          setState(() {
                            loading = false;
                          });
                          _navigateToScreen(context, selectedTeacher);
                        });
                      }
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: Text("Next",
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange))),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _navigateToScreen(BuildContext context, dynamic selectedTeacher) {
    if (StateContainer.of(context).isConnected) {
      Navigator.of(context).push(MaterialPageRoute<Null>(
          builder: (BuildContext context) => SelectStudentScreen(
                selectedTeacher: selectedTeacher,
                // message: messageData,
              )));
    }
  }
}

class TeacherDetails extends StatelessWidget {
  final dynamic teacher;
  final String selected;

  const TeacherDetails(this.teacher, this.selected, {Key key})
      : super(key: key);

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
                      color: Colors.red,
                      border: Border.all(
                          color: selected == teacher['endPointName']
                              ? Colors.green
                              : Colors.grey,
                          width: 5.0),
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
