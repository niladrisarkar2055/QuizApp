import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentDashBoard.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student%20Folder/StudentMain.dart';
import 'package:quizapp/Teacher%20Folder/TeachersMain.dart';





class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SpeEdlabs QuizApp'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 4,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration:  BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0)
                )),
              padding: EdgeInsets.all(20),
              child: Column(children: [
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: Text(
                    "Welcome to QuizApp",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentMain()));
                        }),
                        child: Text("Student"),
                        
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(180, 158, 255, 141)
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeacherMain()));
                        }),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(189, 96, 209, 215)
                        ),
                        child: Text("Teacher"),
                      )),
                ),
              ]),
            ),
          ),
        ));
  }
}