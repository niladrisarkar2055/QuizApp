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
            backgroundColor: Colors.deepPurple[400],
            elevation: 10,
            title: Text('Student Dashboard'),
            actions: [
              IconButton(
                onPressed: (() {
                      context.read<AuthService>().signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Verification()));
                    }),
                icon: Icon(Icons.logout))
            ],
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
                Tab(text: "Old", icon: Icon(Icons.face_unlock_rounded)),
                Tab(text: "New", icon: Icon(Icons.new_label),), ],
              
            ),
          ),
          
          body: Container(
            decoration: const BoxDecoration(
                     gradient: LinearGradient(colors: [
                      // Color.fromARGB(255, 63, 30, 79),Color.fromARGB(255, 101, 42, 116),
                      //  Color.fromARGB(255, 63, 30, 79)
                      Colors.white,Color.fromARGB(255, 84, 51, 141)
                      
                    ],)),
            child: TabBarView(
              children: [OldQuizForStudents(), NewQuizesForStudents()],
            ),
          )
          ),
    );
  }
}
