import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizListCard.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class OldQuizForStudents extends StatefulWidget {
  const OldQuizForStudents({Key? key}) : super(key: key);

  @override
  State<OldQuizForStudents> createState() => _OldQuizForStudentsState();
}

class _OldQuizForStudentsState extends State<OldQuizForStudents> {
  List<dynamic> oldQuizList = [];
  bool isloading = false;
  late int k;
  getOldQuizList() async {
    List results = await DatabaseManager().getQuizList();
    print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isAfter(quizDateTime.toDate()))) {
        oldQuizList.add(results[i]);
      }
    }
    if (mounted) {
      setState(() {
        isloading = true;
      });
    }
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
    return isloading
        ? SafeArea(
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
                      if (oldQuizList.length > 0) {}
                      return Container(
                        height: 250,
                        width: 200,
                        margin: EdgeInsets.all(7),
                        child: QuizcardStudentSide(
                          
                          batch: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                              ['Batch'],
                          dateTime: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                              ['Date & Time'],
                          questionList: oldQuizList[index]['QuizzQuestions'],
                          quizName: oldQuizList[index]['QuizName']['QuizName'],
                          quizSubject: oldQuizList[index]['QuizzInfo']
                              ['QuizzInfo']['Subject'],
                        ),
                      );
                      // QuizcardStudentSide(
                      //   batch: 'IIT - JEE',
                      //   dateTime: oldQuizList[index +1]['QuizzInfo']['QuizzInfo']
                      //       ['Date & Time'],
                      //   questionList: oldQuizList[index + 1]['QuizzQuestions'],
                      //   quizName: oldQuizList[index + 1]['QuizName']['QuizName'],
                      //   quizSubject: oldQuizList[index + 1]['QuizzInfo']['Subject'],
                      // )
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 2,
                      // mainAxisSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            // color: Colors.white,
            child:  Center(
              child: SpinKitThreeBounce(
                
                color: Colors.deepPurple[700],
                size: 50.0,
              ),
            ),
          );
  }
}
