import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/data.dart';
import 'package:data/models/class_students.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/main.dart';
import 'package:jamaica/state/state_container.dart';

class SelectStudentScreen extends StatefulWidget {
  final dynamic selectedTeacher;
  // final String message;

  SelectStudentScreen({Key key, this.selectedTeacher})
      : super(key: key);

  @override
  _SelectStudentScreenState createState() => _SelectStudentScreenState();
}

class _SelectStudentScreenState extends State<SelectStudentScreen> {
  List<Student> studentList = [];
  String selectedStudent;
  String message;

  @override
  Widget build(BuildContext context) {
    message =StateContainer.of(context).receiveMessage;
    final standardSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    final selectedTeacher = jsonDecode(widget.selectedTeacher['endPointName']);
    ClassSession classSession =
        standardSerializers.deserialize(selectedTeacher);

    final newJson = jsonDecode(message);
    ClassStudents classStudent = standardSerializers.deserialize(newJson);
    print("class students..${classStudent.students}");
    studentList.clear();
    for (var i = 0; i < classStudent.students.length; i++) {
      studentList.add(classStudent.students[i]);
    }
    MediaQueryData media = MediaQuery.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        children: <Widget>[
          Container(
            height: orientation == Orientation.portrait
                ? media.size.height * .18
                : media.size.height * .25,
            child: Center(
              child: Column(
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(50.0)),
                        image: DecorationImage(
                          image:
                              AssetImage('assets/stories/images/002page5.jpg'),
                        )),
                    width: orientation == Orientation.portrait
                        ? media.size.width * 0.2
                        : media.size.width * .15,
                    height: orientation == Orientation.portrait
                        ? media.size.height * .1
                        : media.size.height * .2,
                  ),
                  new Container(
                      child: new Text(classSession.teacherName,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: new TextStyle(
                              fontSize: media.size.height * .03,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis)),
                  new Container(
                      child: new Text(classSession.sessionId,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: new TextStyle(
                              fontSize: media.size.height * .01,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              color: Colors.white70,
              width: media.size.width * .9,
              height: media.size.height * .004,
            ),
          ),
          Container(
            height: orientation == Orientation.portrait
                ? media.size.height * .68
                : media.size.height * .52,
            child: GridView.count(
              key: new Key('student_list_page'),
              primary: true,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              crossAxisCount: media.size.height > media.size.width ? 4 : 4,
              children: studentList
                  .map((t) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedStudent = t.id;
                        });
                      },
                      child: StudentDetails(t, selectedStudent)))
                  .toList(growable: false),
            ),
          ),
          Container(
            height: orientation == Orientation.portrait
                ? media.size.height * .08
                : media.size.height * .1,
            child: Center(
              child: InkWell(
                onTap: () async {
                await  StateContainer.of(context).student(selectedStudent);
                  ClassJoin classJoin = ClassJoin((b) => b
                    ..studentId = selectedStudent
                    ..sessionId = classStudent.sessionId);
                  final classJoinJson =
                      standardSerializers.serialize(classJoin);
                  final classJoinJsonString = jsonEncode(classJoinJson);
                  print(classJoinJsonString);

                  StateContainer.of(context)
                      .sendMessageTo(widget.selectedTeacher['endPointId'], classJoinJsonString);

                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return MyApp();
                  }));
                },
                child: Container(
                  height: orientation == Orientation.portrait
                      ? media.size.height * .06
                      : media.size.height * .1,
                  width: orientation == Orientation.portrait
                      ? media.size.width * .25
                      : media.size.width * .15,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text("Start",
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StudentDetails extends StatelessWidget {
  final Student studentDetails;
  final String selectedStudent;

  const StudentDetails(this.studentDetails, this.selectedStudent, {Key key})
      : super(key: key);

  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    var size = media.size;
    return Container(
      width: size.width * .25,
      height: orientation == Orientation.portrait
          ? size.height * .15
          : size.height * .2,
      color: selectedStudent == studentDetails.id ? Colors.blue : Colors.orange,
      child: Column(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius:
                    const BorderRadius.all(const Radius.circular(50.0)),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/stories/images/${studentDetails.photo}'),
                )),
            width: orientation == Orientation.portrait
                ? size.width * 0.2
                : size.width * 0.12,
            height: orientation == Orientation.portrait
                ? size.height * .1
                : size.height * .2,
          ),
          new Container(
              child: new Text(studentDetails.name,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: new TextStyle(
                      fontSize: orientation == Orientation.portrait
                          ? size.height * .02
                          : size.height * .05,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
