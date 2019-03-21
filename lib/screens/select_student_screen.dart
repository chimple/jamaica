import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/data.dart';
import 'package:data/models/class_students.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/main.dart';
import 'package:jamaica/state/state_container.dart';

class SelectStudentScreen extends StatefulWidget {
  final dynamic selectedTeacher;
  final dynamic message;

  SelectStudentScreen({Key key, this.selectedTeacher, this.message})
      : super(key: key);

  @override
  _SelectStudentScreenState createState() => _SelectStudentScreenState();
}

class _SelectStudentScreenState extends State<SelectStudentScreen> {
  List<Student> studentList = [];
  String selectedStudent;
  ClassStudents classStudents;

  @override
  Widget build(BuildContext context) {
    if (!StateContainer.of(context).isConnected) {
      return Center(
        child: SizedBox(
            height: 30.0, width: 30.0, child: CircularProgressIndicator()),
      );
    }

    classStudents = StateContainer.of(context).classStudents;

    final standardSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    final selectedTeacher = jsonDecode(widget.selectedTeacher['endPointName']);
    ClassSession classSession =
        standardSerializers.deserialize(selectedTeacher);
    studentList.clear();
    for (var i = 0; i < classStudents.students.length; i++) {
      studentList.add(classStudents.students[i]);
    }
    MediaQueryData media = MediaQuery.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: orientation == Orientation.portrait ? 1 : 2,
            child: Container(
              height: orientation == Orientation.portrait
                  ? media.size.height * .18
                  : media.size.height * .25,
              child: Center(
                child: Column(
                  children: <Widget>[
                    new Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0)),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/stories/images/002page5.jpg'),
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
                                fontSize: orientation == Orientation.portrait
                                    ? media.size.height * .03
                                    : media.size.height * .05,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis)),
                    new Container(
                        child: new Text(classSession.sessionId,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: new TextStyle(
                                fontSize: media.size.height * .02,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              color: Colors.white70,
              width: media.size.width * .9,
              height: orientation == Orientation.portrait
                  ? media.size.height * .004
                  : media.size.height * .005,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: media.size.width * .05),
              width: media.size.width,
              height: orientation == Orientation.portrait
                  ? media.size.height * .04
                  : media.size.height * .08,
              child: Text("Select Your Photo",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                      fontSize: orientation == Orientation.portrait
                          ? media.size.height * .03
                          : media.size.height * .06,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis)),
          Expanded(
            flex: orientation == Orientation.portrait ? 4 : 3,
            child: Container(
              height: orientation == Orientation.portrait
                  ? media.size.height * .64
                  : media.size.height * .48,
              child: GridView.count(
                key: new Key('student_list_page'),
                primary: true,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: orientation == Orientation.portrait
                    ? media.size.width / (media.size.height / 1.5)
                    : media.size.width / (media.size.height * 1.3),
                crossAxisCount: 4,
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
          ),
          Container(
            height: orientation == Orientation.portrait
                ? media.size.height * .08
                : media.size.height * .1,
            child: Center(
              child: InkWell(
                onTap: () async {
                  await StateContainer.of(context).student(selectedStudent);
                  ClassJoin classJoin = ClassJoin((b) => b
                    ..studentId = selectedStudent
                    ..sessionId = classStudents.sessionId);
                  final classJoinJson =
                      standardSerializers.serialize(classJoin);
                  final classJoinJsonString = jsonEncode(classJoinJson);
                  print(classJoinJsonString);

                  StateContainer.of(context).sendMessageTo(
                      widget.selectedTeacher['endPointId'],
                      classJoinJsonString);

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
                    border: new Border.all(color: Colors.black, width: 2.0),
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
      child: Column(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                    color: selectedStudent == studentDetails.id
                        ? Colors.green
                        : Colors.grey,
                    width: 5.0),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(60.0)),
                image: DecorationImage(
                  image: AssetImage('assets/stories/images/002page3.jpg'),
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
