import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizListCard.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class NewQuizesForStudents extends StatefulWidget {
  const NewQuizesForStudents({Key? key}) : super(key: key);

  @override
  State<NewQuizesForStudents> createState() => _NewQuizesForStudentsState();
}

class _NewQuizesForStudentsState extends State<NewQuizesForStudents> {
  List<dynamic> newQuizList = [];
  bool isLoading = false;
  getnewQuizList() async {
    List results = await DatabaseManager().getQuizList();
    print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isBefore(quizDateTime.toDate()))) {
        
          newQuizList.add(results[i]);
        
      }
    }

     if (mounted) {
      setState(() {
        isLoading = true;
      });
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
    return !isLoading? Transform.scale(
   scale: 0.1,
  child: CircularProgressIndicator(
    color: Colors.white,
    backgroundColor: Colors.blue.withOpacity(0.2),
    strokeWidth: 20,
  ),
):SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: newQuizList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) {
              return QuizcardStudentSide(
                  batch: newQuizList[index]['QuizzInfo']['QuizzInfo']
                          ['Batch'],
                  dateTime: newQuizList[index]['QuizzInfo']['QuizzInfo']
                      ['Date & Time'],
                  questionList: newQuizList[index]['QuizzQuestions'],
                  quizName: 
                  newQuizList[index]['QuizName']['QuizName'],

                   quizSubject: newQuizList[index]['QuizzInfo']['QuizzInfo']['Subject'],
                  
                  );
            },
          ),
         
        ],
      ),
    );
  }
}
