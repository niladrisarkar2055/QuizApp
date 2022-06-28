import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/SignInPage.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentInfo.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';
import 'package:quizapp/Student Folder/Services/Databasemanager.dart';

import '../Helper/SharedPreference.dart';
import 'BottomNavigation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              'Login',
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
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter valid name id as abc@gmail.com'),
              ),
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  // context.read<AuthService>().signUp(
                  //     email: emailController.text.trim(),
                  //     password: passwordController.text.trim());

                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  final User? user =
                      (await _auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text))
                          .user;

                  // DatabaseManager().createStudent(
                  //   emailController.text,nameController.text,user!.uid
                  // );
                  // ignore: use_build_context_synchronously

                  
                  HelperFunctions.saveUserLoggedInSharedPreference(true);
                  HelperFunctions.saveUserEmailSharedPreference(
                      emailController.text);
                  HelperFunctions.saveUserNameSharedPreference(
                      nameController.text);
                  


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Studentinfo(
                              email: emailController.text.trim(),
                              uID: user!.uid)));
                },
                child: const Text(
                  'Sign Up ',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  // ignore: unrelated_type_equality_checks
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                },
                //IF NO ACOUNT IS YET CREATED

                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
