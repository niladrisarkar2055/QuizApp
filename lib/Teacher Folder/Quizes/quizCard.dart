import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Teacher%20Folder/Quizes/teacherQuizReport.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';


class QuizListCard extends StatefulWidget {
  List<dynamic> questionList;
  String quizName;
  String quizSubject;
  String teacherEmail;
  Timestamp dateTime;
  String batch;

  QuizListCard(
      {required this.batch,
      required this.dateTime,
      required this.questionList,
      required this.quizName,
      required this.quizSubject,
      required this.teacherEmail});

  @override
  _QuizListCardState createState() => _QuizListCardState();
}

class _QuizListCardState extends State<QuizListCard> {
  //for fetching database manager methods
  DatabaseManager databaseManager = new DatabaseManager();

  //onclick a chatroom is created and user is taken to the messagebox is inside

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderOnForeground: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
            onTap: () async {},
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.5), BlendMode.dstATop),
                    image:  AssetImage('assets/${widget.quizSubject}.jpg'),
                    fit: BoxFit.cover,
                  )),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(begin: Alignment.bottomCenter, colors: [
                      Colors.deepPurpleAccent.withOpacity(.3),
                      Colors.deepPurpleAccent.withOpacity(.1),
                    ])),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(13),
                    child: Text(
                      widget.quizName.toUpperCase(),
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print(widget.quizName);
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizReportTeacher(
                                      quizName: widget.quizName, quizSubject: widget.quizSubject)));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, elevation: 0),
                        child: const Text(
                          'See Report',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ]),
              ),
            )),
      ),
    );
  }
}