import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/StudentorTeacherPage.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/Teacher_SignInPage.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherinfoPage.dart';
import 'package:quizapp/Teacher%20Folder/Services/AuthtenticationServices.dart';
import 'package:quizapp/main.dart';

import '../Quizes/newQuizes.dart';
import '../Quizes/oldQuizes.dart';

class TeacherHomePage extends StatefulWidget {
  String teacherEmail;
  String teacherUid;
  TeacherHomePage({Key? key, required this.teacherEmail, required this.teacherUid}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _selectedIndex = 0;
  late String tEmail;
  List<Widget> quizpages = <Widget>[const OldQuizzes(), NewQuizzes()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      tEmail = widget.teacherEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            backgroundColor: Colors.deepPurpleAccent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeacherInfo(
                                    email: widget.teacherEmail,
                                    uID: widget.teacherUid,
                                  )));
                    },
                    icon: const Icon(Icons.menu)),
                const Text('Teacher Portal'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(60, 30),
                      primary: Colors.white,
                      onPrimary: Colors.deepPurpleAccent,
                    ),
                    onPressed: (() {
                      context.read<AuthService>().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Verification()));
                    }),
                    child: const Icon(Icons.logout))
              ],
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: "Old",
                ),
                Tab(
                  text: "New",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [OldQuizzes(), NewQuizzes()],
          )),
    );
  }
}