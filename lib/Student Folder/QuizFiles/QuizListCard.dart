import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizPage.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class QuizcardStudentSide extends StatefulWidget {
  List<dynamic> questionList;
  String? quizName;
  String? quizSubject;
  Timestamp dateTime;
  String? batch;
  QuizcardStudentSide(
      {required this.batch,
      required this.dateTime,
      required this.questionList,
      required this.quizName,
      required this.quizSubject});

  @override
  State<QuizcardStudentSide> createState() => _QuizcardStudentSideState();
}

class _QuizcardStudentSideState extends State<QuizcardStudentSide> {
  DatabaseManager databaseManager = new DatabaseManager();

  //onclick a chatroom is created and user is taken to the messagebox is inside

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Quizpage(
                  ourquestionList: widget.questionList,
                  ourquizName: widget.quizName!,
                  ourquizSubject: widget.quizSubject,
                  ourdateTime: widget.dateTime,
                  ourbatch: widget.batch,
                ),
              ));
          print('This is questions --->  ');
          print(widget.questionList);
          print(widget.quizName);
          print(widget.quizSubject);
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                        "${widget.dateTime.toDate().day}/${widget.dateTime.toDate().month}"),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.quizName!,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                        "${widget.dateTime.toDate().hour}:${widget.dateTime.toDate().minute}"),
                    SizedBox(
                      width: 30,
                    ),
                    Text(widget.batch!)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
