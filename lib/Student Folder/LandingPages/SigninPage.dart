import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/BottomNavigation.dart';
import 'package:quizapp/Student Folder/LandingPages/SignUpPage.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentDashBoard.dart';
import 'package:quizapp/Student Folder/LandingPages/StudentInfo.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';
import 'package:quizapp/Student Folder/Services/Databasemanager.dart';
import 'package:quizapp/Student%20Folder/Helper/SharedPreference.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   DatabaseManager databaseManager = DatabaseManager();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             Text(
//               'Student Login',
//               style: TextStyle(fontSize: 26.0),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0),
//               child: Center(
//                 child: Container(
//                     width: 200,
//                     height: 150,
//                     child: Image.asset('assets/speedlabsLogo.png')),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     hintText: 'Enter valid email id as abc@gmail.com'),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 15.0, right: 15.0, top: 15, bottom: 0),
//               child: TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     hintText: 'Enter secure password'),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 50,
//               width: 250,
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(20)),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   // ignore: unrelated_type_equality_checks
//                   // if (SignIn(emailController.toString(),
//                   //         passwordController.toString()) ==
//                   //     1) {
//                   // context.read<AuthService>().signIn(
//                   //     email: emailController.text.trim(),
//                   //     password: passwordController.text.trim());

//                   final FirebaseAuth _auth = FirebaseAuth.instance;
//                   final User? user = (await _auth.signInWithEmailAndPassword(
//                           email: emailController.text,
//                           password: passwordController.text))
//                       .user;
//                   print("---> User signed in");

//                   // sharedpref();
//                   int num = await databaseManager.fetch_name_and_phnno();
//                   if (num == 2) {
//                     // ignore: use_build_context_synchronously
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const BottomNavigation()));
//                   } else if (num != 2) {
//                     // ignore: use_build_context_synchronously
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Studentinfo(
//                                 email: emailController.text.trim(),
//                                 uID: user!.uid)));
//                   }
//                 },
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),

//             //SignUp
//             Container(
//               height: 50,
//               width: 250,
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(20)),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // ignore: unrelated_type_equality_checks
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SignUpPage()));
//                 },
//                 //IF NO ACOUNT IS YET CREATED

//                 child: const Text(
//                   'Sign Up',
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//               ),
//             ),

//             const SizedBox(
//               height: 100,
//             ),
//             const Text('New User?Create Account')
//           ],
//         ),
//       ),
//     );
//   }

//   Future<int> SignIn(String emailController, String passwordController) async {
//     String email = emailController;
//     dynamic currUser = await DatabaseManager().fetchStudentinfo(email);

//     if (currUser != null) {
//       return 1;
//     } else {
//       return 0;
//     }
//   }

//   Future<void> sharedpref() async {
//     String myEmail = '';
//     String myName = '';
//     String myUid = '';
//     String myPhone = '';
//     final userdata = FirebaseAuth.instance.currentUser!;
//     if (userdata != null) {
//       await FirebaseFirestore.instance
//           .collection("Students")
//           .doc(userdata.uid)
//           .get()
//           .then((ds) {
//         setState(() {
//           myEmail = ds.data()!['Email'];
//           myName = ds.data()!['name'];
//           myUid = ds.data()!['uID'];
//           myPhone = ds.data()!['number'];
//         });
//         print('this is:' + myName);
//       });
//     }

//     HelperFunctions.saveUserLoggedInSharedPreference(true);
//     HelperFunctions.saveUserEmailSharedPreference(myEmail);
//     HelperFunctions.saveUserNameSharedPreference(myName);
//   }
// }
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
              'Student Login',
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
              height: 20,
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
                  // ignore: unrelated_type_equality_checks
                  // if (SignIn(emailController.toString(),
                  //         passwordController.toString()) ==
                  //     1) {
                  // context.read<AuthService>().signIn(
                  //     email: emailController.text.trim(),
                  //     password: passwordController.text.trim());

                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  final User? user = (await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text))
                      .user;
                  print("---> User signed in");
                  // ignore: use_build_context_synchronously
                  // sharedpref();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Studentinfo(
                              email: emailController.text.trim(),
                              uID: user!.uid
                             )));
                 
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //SignUp
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
                          builder: (context) => const SignUpPage()));
                },
                //IF NO ACOUNT IS YET CREATED

                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            const SizedBox(
              height: 100,
            ),
            const Text('New User?Create Account')
          ],
        ),
      ),
    );
  }

  Future<int> SignIn(String emailController, String passwordController) async {
    String email = emailController;
    dynamic currUser = await DatabaseManager().fetchStudentinfo(email);

    if (currUser != null) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<void> sharedpref()  async {
  String myEmail = '';
  String myName = '';
  String myUid = '';
  String myPhone = '';
  final userdata = FirebaseAuth.instance.currentUser!;
    if (userdata != null) {
     await FirebaseFirestore.instance
          .collection("Students")
          .doc(userdata.uid)
          .get()
          .then((ds) {
            setState(() {
              
            
        myEmail = ds.data()!['Email'];
        myName = ds.data()!['name'];
        myUid = ds.data()!['uID'];
        myPhone = ds.data()!['number'];
        });
        print('this is:'+ myName);
      });
    }


      HelperFunctions.saveUserLoggedInSharedPreference(true);
                  HelperFunctions.saveUserEmailSharedPreference(
                      myEmail);
                  HelperFunctions.saveUserNameSharedPreference(
                      myName);


  }
}