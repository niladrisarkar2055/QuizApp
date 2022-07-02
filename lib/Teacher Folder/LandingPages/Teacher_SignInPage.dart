import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Teacher%20Folder/HelperFunction_Teacher/sharedpreference.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherHomePage.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherinfoPage.dart';
import 'package:quizapp/Teacher%20Folder/Services/AuthtenticationServices.dart';

import 'package:provider/provider.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Teacher Login',
              style: TextStyle(fontSize: 26.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/speedlabsLogo.png')),
              ),

              //
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 47, 129, 24),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  context.read<AuthService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  final User? user = (await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text))
                      .user;
                  // sharedpref();
                  int num =
                      await DatabaseManager().Teacher_fetch_name_and_phnno();
                  print("this is status of teacher:"+ num.toString());
                  if (await DatabaseManager().Teacher_fetch_name_and_phnno()==3) {
                    // ignore: use_build_context_synchronously
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherHomePage(
                                  teacherEmail: emailController.toString(),
                                )));
                  } 
                  
                  else if (await DatabaseManager()
                          .Teacher_fetch_name_and_phnno() !=
                      3) {
                    // ignore: use_build_context_synchronously
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherInfo(
                                email: emailController.text.trim(),
                                uID: user!.uid)));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('New User? Create Account')
          ],
        ),
      ),
    );
  }

  Future<void> sharedpref() async {
    String myEmail = '';
    String myName = '';
    String myUid = '';
    String myPhone = '';
    final userdata = FirebaseAuth.instance.currentUser!;
    if (userdata != null) {
      await FirebaseFirestore.instance
          .collection("Teachers")
          .doc(userdata.uid)
          .get()
          .then((ds) {
        setState(() {
          myEmail = ds.data()!['Email'];
          myName = ds.data()!['name'];
          myUid = ds.data()!['uID'];
          myPhone = ds.data()!['number'];
        });
        print('this is:' + myName);
      });
    }

    HelperFunctions.Teacher_saveUserLoggedInSharedPreference(true);
    HelperFunctions.Teacher_saveUserEmailSharedPreference(myEmail);
    HelperFunctions.Teacher_saveUserNameSharedPreference(myName);
  }
}
