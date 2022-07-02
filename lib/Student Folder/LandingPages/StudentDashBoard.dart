import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/SignInPage.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/NewQuizForStudents.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/OldQuizForStudents.dart';
import 'package:quizapp/StudentorTeacherPage.dart';


class StudentDashBoard extends StatefulWidget {
  const StudentDashBoard({Key? key}) : super(key: key);

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  int _selectedIndex = 0;
  late String tEmail;
  List<Widget> quizpages = <Widget>[
    OldQuizForStudents(), NewQuizesForStudents()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Student Portal'),
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
              tabs: [Tab(text: "Old", icon: Icon(Icons.face_unlock_rounded),),Tab(text: "New", icon: Icon(Icons.new_label),), ],
              
            ),
          ),
          
          body: Container(
            decoration: const BoxDecoration(
                     gradient: LinearGradient(colors: [
                      Color.fromARGB(194, 95, 166, 85),Color.fromARGB(104, 42, 150, 65)
                      
                    ],)),
            child: TabBarView(
              children: [OldQuizForStudents(), NewQuizesForStudents()],
            ),
          )
          ),
    );
  }
}
