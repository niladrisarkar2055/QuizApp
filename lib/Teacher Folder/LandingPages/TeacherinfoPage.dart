import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/StudentorTeacherPage.dart';


import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherHomePage.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';

class TeacherInfo extends StatefulWidget {
  String email;
  String uID;

  TeacherInfo({Key? key, required this.email, required this.uID})
      : super(key: key);

  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(185, 219, 133, 234),
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome, ${widget.email}",
                  style: const TextStyle(
                      fontSize: 32.0,
                      color: Color.fromARGB(255, 52, 8, 48),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                      hintText: 'Choose your department'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name '),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: numberController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No.',
                      hintText: 'Add your number'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    DatabaseManager().createTeacher(
                        widget.email,
                        nameController.text.trim(),
                        widget.uID,
                        numberController.text.trim(),
                        subjectController.text.trim());
                    DatabaseManager().createTUser( widget.email, "Teacher");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TeacherHomePage(teacherEmail: widget.email)));
                  },
                  child: const Text('Save')),

                  // ElevatedButton(
                  // onPressed: () async {
                    
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               Verification()));
                  // },
                  // child: const Text('Go to'))

            ]),
          ),
        ),
      ),
    );
  }
}
                    
                    // for (int i = 1; i < 11; i++) {
                    //   DatabaseManager().createquestion(
                    //       'Maths',
                    //       'Question $i',
                    //       'option1',
                    //       'option2',
                    //       'option3',
                    //       'option4',
                    //       'answer');
                    // }
                    