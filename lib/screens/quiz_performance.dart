import 'package:data/models/class_students.dart';
import 'package:data/models/quiz_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/state_container.dart';

class QuizPerformance extends StatelessWidget {
  const QuizPerformance({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ClassStudents classStudents;
    classStudents = StateContainer.of(context).classStudents;
    QuizUpdate studentsPerformance = StateContainer.of(context).quizUpdate;
    List<Widget> sttudentsList = [];
    int i = 1;
    studentsPerformance.performances.forEach((sp) {
      classStudents.students.forEach((e) {
        String studentId = sp.studentId.toString();
        String mydata = e.id.toString();
        if (studentId == mydata) {
          sttudentsList.add(Card(
            color: Colors.pink,
            child: ListTile(
              leading: Text("${i++}"),
              title: Center(child: Text(e.name)),
              trailing: Text("${sp.score}"),
            ),
          ));
        }
      });
    });

    return Material(
        child: Column(
      children: <Widget>[
        Expanded(
          child: ListView(children: sttudentsList),
        ),
        Center(
          child: SizedBox(
            height: 40.0,
            width: 100.0,
            child: RaisedButton(
              child: Text("click to go"),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        )
      ],
    ));
  }
}
