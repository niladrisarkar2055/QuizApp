import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  final CollectionReference userlist =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference teacherList =
      FirebaseFirestore.instance.collection('Teachers');
  final CollectionReference maths =
      FirebaseFirestore.instance.collection('Maths');
  final CollectionReference physics =
      FirebaseFirestore.instance.collection('Physics');
  final CollectionReference chemistry =
      FirebaseFirestore.instance.collection('Chemistry');
  final CollectionReference quizzes =
      FirebaseFirestore.instance.collection('Quizzes');
  final CollectionReference studentList =
      FirebaseFirestore.instance.collection('Students');

  Future<void> createTeacher(String email, String name, String uId,
      String number, String subject) async {
    Map<String, dynamic> map = {
      'Email': email,
      'Name': name,
      'uID': uId,
      'Number': number,
      'Subject': subject,
      'role': "Teacher"
    };
    return await teacherList.doc(email).set(map);
  }

  // Future getAllMarks(String quizname) async {
  //   List uIDList = [];
  //   await studentList.get().then((value) => value.docs.forEach((element) {
  //         dynamic data = (element.data()!);
  //         uIDList.add(data['uID']);
  //       }));
  //   List studentEmail = [];
  //   List marksList = [];
  //   for (int i = 0; i < uIDList.length; i++) {
  //     await studentList
  //         .doc(uIDList[i])
  //         .collection('AttemptedQuizes')
  //         .get()
  //         .then((value) {
  //       value.docs.forEach((element) {
  //         print(element.data());
  //       });
  //     });
  //   }
  // }
  
  Future getAllMarks(String quizname) async {
    List results = [];
    try {
      await quizzes
          .doc(quizname)
          .collection('Report')
          .orderBy('Marks', descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          results.add(element.data());
        });
      });
      print(results);
      return results;
    } catch (e) {
      print('No one have attempted the quiz yet!');
    }
  }

  Future<dynamic> fetchTeacherinfo(String email) async {
    final user = await teacherList
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });

    return user;
  }

  Future<void> createTUser(String email, String role) async {
    Map<String, dynamic> map = {'Email': email, 'role': role};
    return await userlist.doc(email).set(map);
  }

  Future<void> createquestion(String subject, String question, String option1,
      String option2, String option3, String option4, String answer) async {
    Map<String, dynamic> map = {
      'Question': question,
      'Subject': subject,
      'Option 1': option1,
      'Option 2': option2,
      'Option 3': option3,
      'Option 4': option4,
      'Answer': answer
    };
    return await physics.doc(question).set(map);
  }

  Future<void> createQuiz(String quizName, String subject, String teacherEmail,
      List<dynamic> questionList, DateTime dateTime, String batch) async {
    Map<String, dynamic> infoMap = {
      'TeacherEmail': teacherEmail,
      'Subject': subject,
      'QuizName': quizName,
      'Date & Time': dateTime,
      'Batch': batch
    };

    await quizzes
        .doc(quizName)
        .collection('QuizzInfo')
        .doc(teacherEmail)
        .set(infoMap);
    await teacherList
        .doc(teacherEmail)
        .collection("Quizzes")
        .doc(quizName)
        .collection('QuizzInfo')
        .doc(subject)
        .set(infoMap);

    for (int i = 0; i < questionList.length; i++) {
      Map<String, dynamic> questionMap = {
        'Question': questionList[i]["Question"],
        'Option 1': questionList[i]["Option 1"],
        'Option 2': questionList[i]["Option 2"],
        'Option 3': questionList[i]["Option 3"],
        'Option 4': questionList[i]["Option 4"],
        "Answer": questionList[i]["Answer"],
        'Subject': questionList[i]['Subject']
      };

      quizzes
          .doc(quizName)
          .collection('QuizzQuestions')
          .doc(questionList[i]["Question"])
          .set(questionMap);
      quizzes.doc(quizName).set({'QuizName': quizName});
      teacherList
          .doc(teacherEmail)
          .collection("Quizzes")
          .doc(quizName)
          .collection('QuizzQuestions')
          .doc(questionList[i]["Question"])
          .set(questionMap);
    }
  }

  Future getQuizList() async {
    List<dynamic> quizNameList = [];
    await quizzes.get().then((value) {
      value.docs.forEach((element) {
        quizNameList.add(element.data());
      });
    });

    List<dynamic> quizInfoList = [];

    for (int i = 0; i < quizNameList.length; i++) {
      await quizzes
          .doc(quizNameList[i]['QuizName'])
          .collection('QuizzInfo')
          .get()
          .then((value) => value.docs.forEach((element) {
                quizInfoList.add({
                  'QuizName': quizNameList[i]['QuizName'],
                  'QuizzInfo': element.data()
                });
              }));
    }
    List<dynamic> quizQuestionList = [];
    for (int i = 0; i < quizNameList.length; i++) {
      List<dynamic> oneQuizQuestions = [];
      await quizzes
          .doc(quizNameList[i]['QuizName'])
          .collection('QuizzQuestions')
          .get()
          .then((value) => value.docs.forEach((element) {
                oneQuizQuestions.add(element.data());
              }));
      quizQuestionList.add(oneQuizQuestions);
    }
    // print(quizQuestionList);
    List<dynamic> quizList = [];
    for (int i = 0; i < quizNameList.length; i++) {
      quizList.add({
        'QuizName': quizNameList[i],
        'QuizzInfo': quizInfoList[i],
        'QuizzQuestions': quizQuestionList[i]
      });
    }
    return quizList;
  }

  Future<List<dynamic>> getMathsQuestionList() async {
    List<dynamic> mathsquestions = [];
    await maths.get().then((value) {
      value.docs.forEach((element) {
        mathsquestions.add(element.data());
      });
    });
    return mathsquestions;
  }

  Future<List<dynamic>> getPhysicsQuestionList() async {
    List<dynamic> physicsquestions = [];
    await physics.get().then((value) {
      value.docs.forEach((element) {
        physicsquestions.add(element.data());
      });
    });
    return physicsquestions;
  }

  Future<List<dynamic>> getChemistryQuestionList() async {
    List<dynamic> chemistryquestions = [];
    await chemistry.get().then((value) {
      value.docs.forEach((element) {
        chemistryquestions.add(element.data());
      });
    });
    return chemistryquestions;
  }
}