import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentDashBoard.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  int index = 2;
  @override
  Widget build(BuildContext context) {
    final screen = <Widget>[
      StudentDashBoard(),
      StudentProfilePage()
      
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
          child: IndexedStack(
          index:currentIndex,
          children: screen),
      ),

        bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color.fromARGB(255, 247, 255, 253),
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        iconSize: 20,
        items: const [
          BottomNavigationBarItem(
             
              icon: Icon(Icons.home),
              label: 'DashBoard',
              backgroundColor: Color.fromARGB(255, 152, 72, 169),),

          BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'ProfilePage',
              backgroundColor: Color.fromARGB(255, 152, 72, 169),),
        ],
      ),

    );
  }
}
