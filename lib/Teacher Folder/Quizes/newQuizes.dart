import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Teacher%20Folder/Quizes/quizCard.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';
import 'selectSubject.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewQuizzes extends StatefulWidget {
  NewQuizzes({Key? key}) : super(key: key);

  @override
  State<NewQuizzes> createState() => _NewQuizzesState();
}

class _NewQuizzesState extends State<NewQuizzes> {
  List<dynamic> newQuizList = [];
  bool isLoading = true;

  getnewQuizList() async {
    List results = await DatabaseManager().getQuizList();
    // print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isBefore(quizDateTime.toDate()))) {
        if (mounted) {
          setState(() {
            newQuizList.add(results[i]);
          });
        }
      }
    }
    isLoading = false;
    print('The length of new quiz is: '+ newQuizList.length.toString());
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
    return isLoading
        ? Container(
            color: Colors.white,
            child: const Center(
              child: SpinKitThreeBounce(
                color: Colors.deepPurpleAccent,
                size: 30.0,
              ),
            ),
          )
        : SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: (newQuizList.length),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    itemBuilder: (context, index) {
                      if (newQuizList.length > 0) {
                        return Container(
                            height: 250,
                            width: 200,
                            margin: EdgeInsets.all(7),
                            child: QuizListCard(
                                batch: newQuizList[index]['QuizzInfo']
                                    ['QuizzInfo']['Batch'],
                                dateTime: newQuizList[index]['QuizzInfo']
                                    ['QuizzInfo']['Date & Time'],
                                questionList: newQuizList[index]
                                    ['QuizzQuestions'],
                                quizName: newQuizList[index]['QuizName']
                                    ['QuizName'],
                                quizSubject: newQuizList[index]['QuizzInfo']
                                    ['QuizzInfo']['Subject'],
                                teacherEmail: newQuizList[index]['QuizzInfo']
                                    ['QuizzInfo']['TeacherEmail']));
                      }
                      return Container(
                          height: 250,
                          width: 200,
                          margin: EdgeInsets.all(7),
                          child: Text('No quizzes!!'));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 2,
                      // mainAxisSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SelectSubject(
                                teacherEmail: context.watch<User?>()!.email!)));
                  },
                  backgroundColor: Colors.deepPurpleAccent,
                  label: Row(
                    children: const [
                      Icon(Icons.add),
                      Text('Add New Quiz'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
  }
}
