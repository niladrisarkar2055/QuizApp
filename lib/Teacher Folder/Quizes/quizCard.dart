import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';


class QuizListCard extends StatefulWidget {
  List<dynamic> questionList;
  String? quizName;
  String? quizSubject;
  String? teacherEmail;
  Timestamp dateTime;
  String? batch;

  QuizListCard(
      {required this.batch, required this.dateTime, required this.questionList, required this.quizName, required this.quizSubject, required this.teacherEmail});

  @override
  _QuizListCardState createState() => _QuizListCardState();
}

class _QuizListCardState extends State<QuizListCard> {
  //for fetching database manager methods
  DatabaseManager databaseManager = new DatabaseManager();

  //onclick a chatroom is created and user is taken to the messagebox is inside


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // message(widget.sender, widget.receiver, widget.chatroomId);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Text("${widget.dateTime.toDate().day}/${widget.dateTime.toDate().month}"),
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
                  SizedBox(width: 30,),
                  Text("${widget.dateTime.toDate().hour}:${widget.dateTime.toDate().minute}"),
                  SizedBox(width: 30,),
                  Text(widget.batch!)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}