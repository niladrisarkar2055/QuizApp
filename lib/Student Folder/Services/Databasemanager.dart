import 'package:cloud_firestore/cloud_firestore.dart';

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
      studentEmailList = value['Students'];
    });

    studentEmailList.add(studentemail);
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
    dynamic results = await userlist
        .where("Email", isEqualTo: email)
        .get()
        .catchError((e) {
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
}
