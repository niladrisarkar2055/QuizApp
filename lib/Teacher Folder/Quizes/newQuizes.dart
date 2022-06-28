import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Teacher%20Folder/Quizes/quizCard.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';
import 'selectSubject.dart';

class NewQuizzes extends StatefulWidget {
  NewQuizzes({Key? key}) : super(key: key);

  @override
  State<NewQuizzes> createState() => _NewQuizzesState();
}

class _NewQuizzesState extends State<NewQuizzes> {
  List<dynamic> newQuizList = [];

  getnewQuizList() async {
    List results = await DatabaseManager().getQuizList();
    print('This is quizz List');
    print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isBefore(quizDateTime.toDate()))) {
        setState(() {
          newQuizList.add(results[i]);
        });
      }
    }

    return newQuizList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnewQuizList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: newQuizList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) {
              return QuizListCard(
                  batch: 'IIT - JEE',
                  dateTime: newQuizList[index]['QuizzInfo']['QuizzInfo']
                      ['Date & Time'],
                  questionList: newQuizList[index]['QuizzQuestions'],
                  quizName: 
                  newQuizList[index]['QuizName']['QuizName'],

                  quizSubject: newQuizList[index]['QuizzInfo']['Subject'],
                  teacherEmail: newQuizList[index]['QuizzInfo']['TeacherEmail']
                  );
            },
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SelectSubject(
                          teacherEmail: context.watch<User?>()!.email!)));
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}