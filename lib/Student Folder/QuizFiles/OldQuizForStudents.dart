import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizListCard.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class OldQuizForStudents extends StatefulWidget {
  const OldQuizForStudents({Key? key}) : super(key: key);

  @override
  State<OldQuizForStudents> createState() => _OldQuizForStudentsState();
}

class _OldQuizForStudentsState extends State<OldQuizForStudents> {
  List<dynamic> oldQuizList = [];

  getOldQuizList() async {
    List results = await DatabaseManager().getQuizList();
    print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      Timestamp quizDateTime =
          results[i]['QuizzInfo']['QuizzInfo']['Date & Time'];
      DateTime dateTime = DateTime.now();
      if ((dateTime.isAfter(quizDateTime.toDate()))) {
        setState(() {
          oldQuizList.add(results[i]);
        });
      }
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: oldQuizList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) {
              return QuizcardStudentSide(
                batch: 'IIT - JEE',
                dateTime: oldQuizList[index]['QuizzInfo']['QuizzInfo']
                    ['Date & Time'],
                questionList: oldQuizList[index]['QuizzQuestions'],
                quizName: oldQuizList[index]['QuizName']['QuizName'],
                quizSubject: oldQuizList[index]['QuizzInfo']['Subject'],
              );
            },
          )
        ],
      ),
    );
  }
}
