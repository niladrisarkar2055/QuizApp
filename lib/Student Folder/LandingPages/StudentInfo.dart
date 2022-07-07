import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student Folder/LandingPages/BottomNavigation.dart';
import 'package:quizapp/Student Folder/Services/Databasemanager.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentDashBoard.dart';
import 'package:quizapp/StudentorTeacherPage.dart';

class Studentinfo extends StatefulWidget {
  String email;
  String uID;
  
  Studentinfo({Key? key, required this.email, required this.uID})
      : super(key: key);

  @override
  State<Studentinfo> createState() => _StudentinfoState();
}

class _StudentinfoState extends State<Studentinfo> {
  String value = 'IIT-JEE';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Container(
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              
                color: Colors.deepPurple[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(120),
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(0),
                ),),
            padding: EdgeInsets.all(10),
            // margin: EdgeInsets.all(10),
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Welcome to Quizapp",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
               const SizedBox(
                height: 20,
              ),
              Divider(height: 30 ,thickness: 1,color: Colors.white,),
              const SizedBox(
                height: 30,
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 40),
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   child: TextField(
                  
              //     controller: nameController,
              //     obscureText: false,
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'name',
              //         hintText: 'write down your name'),
              //   ),
              // ),
               Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: nameController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 249, 248, 252), style: BorderStyle.solid)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: Colors.greenAccent, style: BorderStyle.solid)
                        ),
                        labelText: 'Name',
                        labelStyle: TextStyle(color:Color.fromARGB(255, 255, 255, 255),  fontWeight: FontWeight.bold),
                        ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 40),
              //   width: MediaQuery.of(context).size.width * 1.2,
              //   child: TextField(
              //     controller: numberController,
              //     obscureText: false,
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'Phone No.',
              //         hintText: 'Add your number'),
              //   ),
              // ),
               Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: numberController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 255, 255, 255), style: BorderStyle.solid)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: Colors.greenAccent, style: BorderStyle.solid)
                        ),
                        labelText: 'Phone No.',
                        labelStyle: TextStyle(color:Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              const SizedBox(
                height: 20,
              ),
              Container(
                
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple[500],),
                child: DropdownButton<String>(
                  dropdownColor: Colors.deepPurple[500],
                  borderRadius: BorderRadius.circular(20),
                  value: value,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'IIT-JEE',
                      child: Center(
                        child: Text('IIT-JEE',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'CBSE:11-12',
                      child: Center(
                        child: Text('CBSE:11-12',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                  onChanged: (_value) => {
                    setState(() {
                      value = _value!;
                    })
                  },
                ),
              ),
              ElevatedButton(
                  
                  onPressed: () {
                    DatabaseManager().addBatch(widget.email, value);
                    DatabaseManager().createStudent(
                      widget.email,
                      nameController.text.trim(),
                      widget.uID,
                      numberController.text.trim(),
                    );
                    DatabaseManager().createSUser(widget.email, "Student");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentDashBoard()));
                  },
                  child: const Text('Save')),

            ]),
          ),
        ),
      ),
      
    );
  }
}
