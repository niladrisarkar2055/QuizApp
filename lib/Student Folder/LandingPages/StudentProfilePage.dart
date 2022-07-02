import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student Folder/LandingPages/SignInPage.dart';
import 'package:quizapp/Student Folder/Services/AuthServices.dart';
import 'package:quizapp/Student Folder/Services/Databasemanager.dart';
import 'package:quizapp/Student Folder/Services/UserModel.dart';
import 'package:quizapp/StudentorTeacherPage.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  String myEmail = '';
  String myName = '';
  String myUid = '';
  String myPhone = '';
  String myRole = '';
  Future<void> fetchuser() async {
    // dynamic userdata = await DatabaseManager().fetchStudentinfo(email);
    final userdata = FirebaseAuth.instance.currentUser!;
    if (userdata != null) {
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(userdata.uid)
          .get()
          .then((ds) {
        myEmail = ds.data()!['Email'];
        myName = ds.data()!['name'];
        myUid = ds.data()!['uID'];
        myPhone = ds.data()!['number'];
        myRole = ds.data()!['role'];
        print(myEmail);
      });
    }
  }

  @override
  void initState() {
    fetchuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // UserModel? user =
    //     UserModel(context.read<User?>()!.email, context.read<User?>()!.uid);
    // var currUserEmail = user.email;
    // var currUseruid = user.uId;

    return Scaffold(
        appBar: AppBar(
          elevation: 10,
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Student ProflePAGE'),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(212, 219, 66, 194))),
                onPressed: (() {
                  context.read<AuthService>().signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Verification()));
                }),
                child: const Text('Log out'))
          ],
        )),
        body: Container(
           decoration: const BoxDecoration(
                   gradient: LinearGradient(colors: [
                      Color.fromARGB(195, 120, 205, 235),Color.fromARGB(192, 10, 126, 123)
                      
                    ],)
                    ),
          child: Center(
              child: FutureBuilder(
                  future: fetchuser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    }
                    return Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Container(
                             
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                                 gradient: const LinearGradient(colors: [
                                  Color.fromARGB(189, 106, 27, 113),Color.fromARGB(255, 154, 74, 207)
                        
                       ],),
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(20),
                            child: Column(children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Center(
                                child: Text(
                                  "Welcome to Profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Color.fromARGB(255, 255, 255, 255),
                                height: 20,
                                thickness: 1,
                                indent: 5,
                                endIndent: 5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 40),
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Email: $myEmail",
                                        style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),fontSize: 20)),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Name: $myName",
                                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 40),
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Phone no: $myPhone",
                                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 20)),
                                  )),
                            ]),
                          ),
                        ),
                      ),
                    );
                  })),
        ));
  }
}
