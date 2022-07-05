import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/StudentorTeacherPage.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/Teacher_SignInPage.dart';
import 'package:quizapp/Teacher%20Folder/Services/AuthtenticationServices.dart';
import 'package:quizapp/main.dart';

import '../Quizes/newQuizes.dart';
import '../Quizes/oldQuizes.dart';

class TeacherHomePage extends StatefulWidget {
  String teacherEmail;
  TeacherHomePage({Key? key, required this.teacherEmail}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _selectedIndex = 0;
  late String tEmail;
  List<Widget> quizpages = <Widget>[
    const OldQuizzes(),
    NewQuizzes()
  ];
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Teacher Portal'),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    onPressed: (() {
                      context.read<AuthService>().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Verification()));
                    }),
                    child: const Text('Log out'))
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [Tab(text: "Old", icon: Icon(Icons.time_to_leave),),Tab(text: "New", icon: Icon(Icons.add),), ],
              
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.label),
          //       label: 'Old',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.add),
          //       label: 'New',
          //     ),
          //   ],
          //   currentIndex: _selectedIndex,
          //   onTap: _onItemTapped,
          // ),
          body: TabBarView(
            children: [OldQuizzes(), NewQuizzes()],
          )
          ),
    );
  }
}