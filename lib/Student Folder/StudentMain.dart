import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student%20Folder/LandingPages/BottomNavigation.dart';

import 'package:quizapp/Student%20Folder/LandingPages/SigninPage.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentDashBoard.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentInfo.dart';
import 'package:quizapp/Student%20Folder/Services/AuthServices.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class StudentMain extends StatefulWidget {
  StudentMain();

  @override
  State<StudentMain> createState() => _StudentMainState();
}

class _StudentMainState extends State<StudentMain> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
            create: (context) => AuthService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzi App',
        theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const AuthanticationWrapper(),
        routes: {'/home': (context) => const AuthanticationWrapper()},
      ),
    );
  }
}

class AuthanticationWrapper extends StatefulWidget {
  const AuthanticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthanticationWrapper> createState() => _AuthanticationWrapperState();
}

class _AuthanticationWrapperState extends State<AuthanticationWrapper> {
  DatabaseManager databaseManager = DatabaseManager();
  Future<int> check() async {
    int num = await databaseManager.fetch_name_and_phnno();
    print("This is num:" + num.toString());
    return num;
  }

  dynamic userinfo;
  Future<dynamic> CheckRole() async {
    String role = '';
    final userdata = FirebaseAuth.instance.currentUser;
    if (userdata != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userdata.email)
          .get()
          .then((ds) {
        setState(() {
          role = ds.data()!['role'];
          userinfo = role;
        });
        print('this is:' + role);
      });
    }

    return userinfo;
  }

  @override
  void initState() {
    check();
    CheckRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appuser = context.watch<User?>();
    Future<int> sum = check() as Future<int>;
    if (appuser != null) {
      if (userinfo == "Student") {
        // if (sum = 2) {
        //   return StudentDashBoard();
        // } else {
          return Studentinfo(email: appuser.email!, uID: appuser.uid);
        // }
      } else {
        return SignInPage();
      }
    } else {
      return SignInPage();
    }
  }
}
