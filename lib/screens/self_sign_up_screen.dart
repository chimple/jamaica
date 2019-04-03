import 'dart:convert';
import 'dart:io';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/data.dart';
import 'package:data/models/serializers.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/state_container.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:jamaica/storyboards/widgets/drop_down.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfSignUpScreen extends StatefulWidget {
  @override
  _SelfSignUpScreenState createState() {
    return _SelfSignUpScreenState();
  }
}

class _SelfSignUpScreenState extends State<SelfSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _studentName;
  String _standard;
  String _id = "test123";
  String _gender;
  String _image = "xyz";
  List<String> _standardList = ['1', '2', '3', '4', '5', '6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            child: Center(
              child: Text(
                "Self Sign Up",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.black,
              width: 500.0,
              height: 8.0,
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Background_potriat.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Center(
                            child: _image == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      color: const Color(0xFFE18025),
                                      icon: Icon(Icons.add_a_photo),
                                      iconSize: 50.0,
                                      onPressed: () {
                                        openCamera();
                                      },
                                    ),
                                    maxRadius: 50.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage: ExactAssetImage("assets/stories/images/002page3.jpg"),
                                    maxRadius: 50.0,
                                  ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black54,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),

                                // initialValue:

                                //     widget.update ? widget.student.studentName : null,

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Student Name',
                                ),

                                onSaved: (input) {
                                  _studentName = input;
                                },

                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter student name';
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Dropdown(
                            menuItems: _standardList,

                            hintText: 'select standard',

                            // value: widget.update ? widget.student.standard : null,

                            selectedItem: (String value) {
                              _standard = value;
                            },
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Dropdown(
                            menuItems: <String>['male', 'female'],
                            hintText: 'select gender',
                            // value: widget.update ? widget.student.gender : null,
                            selectedItem: (String value) {
                              _gender = value;
                            },
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Center(
                            child: RaisedButton(
                              color: const Color(0xFFE18025),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  print(
                                      "test going on herrrr  $_standard.. $_id $_studentName,,, $_image");
                                      

                                  await StateContainer.of(context).selfSignUp(
                                      _standard,
                                      _id,
                                      _studentName,
                                      _image);

                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  openCamera() async {
    // _image = await ImagePicker.pickImage(
    //     source: ImageSource.camera, maxHeight: 128.0, maxWidth: 128.0);
    // userImage(_image);
  }

  // userImage(File _image) async {
  //   setState(() {
  //     this._image = _image;
  //   });
  // }
}
