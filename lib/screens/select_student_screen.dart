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

  @override
  Widget build(BuildContext context) {
    final standardSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    final selectedTeacher = jsonDecode(widget.selectedTeacher['endPointName']);
    ClassSession classSession =
        standardSerializers.deserialize(selectedTeacher);

    final newJson = jsonDecode(widget.message);
    ClassStudents classStudent = standardSerializers.deserialize(newJson);
    print("class students..${classStudent.students}");

    for (var i = 0; i < classStudent.students.length; i++) {
      studentList.add(classStudent.students[i]);
    }
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor:Colors.orange,
      body: Column(
        children: <Widget>[
          Container(
            height: media.size.height * .2,
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
                    width: media.size.width * 0.15,
                    height: media.size.height * .1,
                  ),
                  new Container(
                      child: new Text(classSession.teacherName,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: new TextStyle(
                              fontSize: media.size.height * .02,
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
              color: Colors.white70,
              width: media.size.width * .9,
              height: media.size.height * .004,
            ),
          ),
          Container(
            height: media.size.height * .68,
            child: GridView.count(
              key: new Key('student_list_page'),
              primary: true,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              crossAxisCount: media.size.height > media.size.width ? 3 : 4,
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
            height: media.size.height * .09,
            child: Center(
              child: InkWell(
                onTap: () async {
                  ClassJoin classJoin = ClassJoin((b) => b
                    ..studentId = selectedStudent
                    ..sessionId = classStudent.sessionId);
                  final classJoinJson =
                      standardSerializers.serialize(classJoin);
                  final classJoinJsonString = jsonEncode(classJoinJson);
                  print(classJoinJsonString);

                  StateContainer.of(context).sendMessageTo(
                      classSession.classId, classJoinJsonString);

                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                    return MyApp();
                  }));
                },
                child: Container(
                  height: media.size.height * .06,
                  width: media.size.width * .2,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text("Start",
                          style: new TextStyle(
                              fontSize: 30.0,
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
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
      ),
      margin: EdgeInsets.all(size.width * .02),
      child: new Stack(
        children: <Widget>[
          Container(
            width: size.width * .3,
            color: selectedStudent == studentDetails.id
                ? Colors.blue
                : Colors.orange,
            child: Column(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(50.0)),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/stories/images/${studentDetails.photo}'),
                      )),
                  width: orientation == Orientation.portrait
                      ? size.width * 0.15
                      : size.width * 0.1,
                  height: size.height * .1,
                ),
                new Container(
                    child: new Text(studentDetails.name,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: new TextStyle(
                            fontSize: size.height * .02, color: Colors.white),
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
