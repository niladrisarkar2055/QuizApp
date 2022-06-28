import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:quizapp/Teacher%20Folder/LandingPages/Teacher_SignInPage.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherinfoPage.dart';
import 'package:quizapp/Teacher%20Folder/Services/AuthtenticationServices.dart';

class TeacherMain extends StatefulWidget {
  
  TeacherMain();

  @override
  State<TeacherMain> createState() => _TeacherMainState();
}

class _TeacherMainState extends State<TeacherMain> {
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
            primarySwatch: Colors.blue,
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
    final userdata = await FirebaseAuth.instance.currentUser!;
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
  void initState(){
     CheckRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appuser = context.watch<User?>();

    if (appuser != null) {
      if (userinfo == "Teacher") {
        return TeacherInfo(email: appuser.email!, uID: appuser.uid);
      } else {
        return SignInPage();
      }
    } else {
      return SignInPage();
    }
  }
}
