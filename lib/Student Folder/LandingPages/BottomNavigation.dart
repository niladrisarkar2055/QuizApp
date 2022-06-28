import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentDashBoard.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final screen = [
    StudentDashBoard(),StudentProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //      title: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         const Text('Student Dashboard'),
              
      //         ElevatedButton(
      //             style: ButtonStyle(
      //                 backgroundColor:
      //                     MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0))),
      //             onPressed: (() {
      //               context.read<AuthService>().signOut();
      //             }),
      //             child: const Text('Log out'))
      //       ],
      //      )
      // ),
      body: IndexedStack(
        index:currentIndex,
        children: screen),

      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        iconSize: 20,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'DashBoard',
              backgroundColor: Color.fromARGB(255, 109, 124, 52)),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'ProfilePage',
              backgroundColor: Color.fromARGB(212, 219, 66, 194)),
        ],
      ),
    );
  }
}
