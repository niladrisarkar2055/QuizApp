import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Teacher%20Folder/Quizes/quizCard.dart';
import 'package:quizapp/Teacher%20Folder/Quizes/selectSubject.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';

class OldQuizzes extends StatefulWidget {
  const OldQuizzes({Key? key}) : super(key: key);

  @override
  State<OldQuizzes> createState() => _OldQuizzesState();
}

class _OldQuizzesState extends State<OldQuizzes> {
  List<dynamic> oldQuizList = [];
  bool isLoading = true;

  getOldQuizList() async {
    List results = await DatabaseManager().getQuizList();
    // print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isAfter(quizDateTime.toDate()))) {
        if (mounted) {
          setState(() {
            oldQuizList.add(results[i]);
          });
        }
      }
    }
    isLoading = false;
    return oldQuizList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOldQuizList();
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
                    itemCount: (oldQuizList.length),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    itemBuilder: (context, index) {
                      if (oldQuizList.length > 0) {
                        return Container(
                        height: 250,
                        width: 200,
                        margin: EdgeInsets.all(7),
                        child: QuizListCard(
                          batch: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                              ['Batch'],
                          dateTime: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                              ['Date & Time'],
                          questionList: oldQuizList[index]['QuizzQuestions'],
                          quizName: oldQuizList[index]['QuizName']['QuizName'],
                          quizSubject: oldQuizList[index]['QuizzInfo']
                              ['QuizzInfo']['Subject'],
                          teacherEmail: oldQuizList[index]['QuizzInfo']
                              ['QuizzInfo']['TeacherEmail'])
                        
                      );
                      }
                      return Container(
                        height: 250,
                        width: 200,
                        margin: EdgeInsets.all(7),
                        child: Text('No quizzes!!')
                      );
                     
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 2,
                      // mainAxisSpacing: 2,
                    ),
                  ),
                ),
                //  SizedBox(height: 10,),FloatingActionButton.extended(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (BuildContext context) => SelectSubject(
                //                   teacherEmail: context.watch<User?>()!.email!)));
                //     },
                //     backgroundColor: Colors.deepPurpleAccent,
                //     label:  Row(
                //       children: const  [
                        
                //         Icon(Icons.add),
                //         Text('Add New Quiz'),
                //       ],
                //     ),
                //   ),
              ],
            ),
        );
  }
}