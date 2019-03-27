import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/data.dart';
import 'package:data/models/class_students.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/main.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/student_details.dart';
import 'package:jamaica/widgets/teacher_details.dart';

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
    if (StateContainer.of(context).classStudents == null) {
      return Center(
        child: SizedBox(
            height: 30.0, width: 30.0, child: CircularProgressIndicator()),
      );
    }

    classStudents = StateContainer.of(context).classStudents;

    final standardSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

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
            child: Center(
              child: TeacherDetails(widget.selectedTeacher),
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
                      onTap: () async {
                        await StateContainer.of(context)
                            .student(selectedStudent);
                        ClassJoin classJoin = ClassJoin((b) => b
                          ..studentId = t.id
                          ..sessionId = classStudents.sessionId);
                        final classJoinJson =
                            standardSerializers.serialize(classJoin);
                        final classJoinJsonString = jsonEncode(classJoinJson);
                        print(classJoinJsonString);

                        StateContainer.of(context).sendMessageTo(
                            widget.selectedTeacher['endPointId'],
                            classJoinJsonString);
                        Navigator.of(context).pushNamed('/chatbot');
                      },
                      child: StudentDetails(t)))
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}
