import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentInfo.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';
import 'package:quizapp/Student Folder/Services/Databasemanager.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizPage.dart';
import 'package:quizapp/Student%20Folder/StudentMain.dart';
import 'package:quizapp/StudentorTeacherPage.dart';
import 'package:quizapp/Teacher%20Folder/TeachersMain.dart';

import 'Student Folder/LandingPages/SigninPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
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
  dynamic userinfo;
  Future<dynamic> CheckRole() async {
   
    String role = '';
    final userdata = FirebaseAuth.instance.currentUser!;
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
    CheckRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appuser = context.watch<User?>();
    // if (appuser != null) {
    //   return Verification();
    //   // Studentinfo(email: appuser.email!, uID: appuser.uid);
    // } else {
    //   return
    //   Verification();
    // }

    if (appuser != null) {
      if (userinfo == 'Student') {
        return StudentMain();
      } else{
        return TeacherMain();
      }
    } else {
      return Verification();
    }
  }
}
