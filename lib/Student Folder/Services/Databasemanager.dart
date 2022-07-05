import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  final CollectionReference userlist =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference studentList =
      FirebaseFirestore.instance.collection('Students');
  final CollectionReference batch =
      FirebaseFirestore.instance.collection('Batch');
  final CollectionReference quizzes =
      FirebaseFirestore.instance.collection('Quizzes');

 Future<void> addBatch(String studentemail, String batchName) async {
    List<dynamic> studentEmailList = [];

    await batch.doc(batchName).get().then((value) {
      if (value.exists) {
        studentEmailList = value['Students'];
      } else {
        studentEmailList = [];
      }
    });

    if (studentEmailList.contains(studentemail) == false) {
      studentEmailList.add(studentemail);
    }

    return await batch
        .doc(batchName)
        .set({'Batch Name': batchName, 'Students': studentEmailList});
  }

  Future<void> createStudent(
      String email, String name, String uId, String number) async {
    Map<String, dynamic> map = {
      'Email': email,
      'name': name,
      'uID': uId,
      'number': number,
      'role': "Student"
    };
    return await studentList.doc(uId).set(map);
  }

  Future<void> createSUser(String email, String role) async {
    Map<String, dynamic> map = {'Email': email, 'role': role};
    return await userlist.doc(email).set(map);
  }

  Future<dynamic> getUserRole(String email) async {
    dynamic results =
        await userlist.where("Email", isEqualTo: email).get().catchError((e) {
      print(e.toString());
    });

    print("This is results: " + results);
    return results;
  }

  Future<dynamic> fetchStudentinfo(String email) async {
    final user = await studentList
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });

    return user;
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
    print(quizQuestionList);
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

  //FOR QUIZ MARKS
Future<void> quizmarks(String quizname, int count, String uid, String email) async {
    Map<String, dynamic> map = {'marks': count, 'quizname': quizname, 'StudentEmail': email};
    await studentList
        .doc(uid)
        .collection('AttemptedQuizes')
        .doc(quizname)
        .set(map);
  }

  Future<void> quizans(
      String quizname,
      int index,
      String question,
      String selectedoption,
      String answer,
      String option1,
      String option2,
      String option3,
      String option4) async {
    final userdata = FirebaseAuth.instance.currentUser!;
    String uid = userdata.uid;
    Map<String, String> newmap = {
      'Question': question.toString(),
      'Option 1': option1,
      'Option 2': option2,
      'Option 3': option3,
      'Option 4': option4,
      'Selectedoption': selectedoption.toString(),
      'Answer': answer.toString(),
    };
    await studentList
        .doc(uid)
        .collection('AttemptedQuizes')
        .doc(quizname)
        .collection('Question_and_Ans')
        .doc((index + 1).toString())
        .set(newmap);
  }

  Future getQuizans(String quizname) async {
    final userdata = FirebaseAuth.instance.currentUser!;
    String uid = userdata.uid;
    List Quizquestions = [];
    await studentList
        .doc(uid)
        .collection('AttemptedQuizes')
        .doc(quizname)
        .collection('Question_and_Ans')
        .get()
        .then((value) => value.docs.forEach((element) {
              Quizquestions.add(element.data());
            }));

    return Quizquestions;
  }

  Future<int> fetchquizmarks(String quizname) async {
    final userdata = FirebaseAuth.instance.currentUser!;
    String uid = userdata.uid;

    int mymarks = -1;
    await studentList
        .doc(uid)
        .collection('AttemptedQuizes')
        .doc(quizname)
        .get()
        .then((ds) => {
              if (ds.exists)
                {
                  if (ds.data()!['marks'] > -1) {mymarks = ds.data()!['marks']}
                }
            });
    print("MY MARKS FOR THE QUIZ " + quizname + " is " + mymarks.toString());
    return mymarks;
  }

  // ignore: non_constant_identifier_names
  Future<int> fetch_name_and_phnno() async {
    int name = -1;
    int phnno = -1;

    final userdata = FirebaseAuth.instance.currentUser!;
    if (userdata != null) {
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(userdata.uid)
          .get()
          .then((ds) => {
                if (ds.exists)
                  {
                    if (ds.data()!['name'] != "") {name = 1},
                    if (ds.data()!['number'] != "") {phnno = 1},
                  }
              });
    }

    return (name + phnno);
  }
}
