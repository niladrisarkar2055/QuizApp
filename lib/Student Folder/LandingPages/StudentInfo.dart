import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student Folder/LandingPages/BottomNavigation.dart';
import 'package:quizapp/Student Folder/Services/Databasemanager.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 194, 186, 196),
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  "Welcome, ${widget.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 83, 11, 79),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: nameController,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'name',
                      hintText: 'write down your name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width * 1.2,
                child: TextField(
                  controller: numberController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No.',
                      hintText: 'Add your number'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: DropdownButton<String>(
                  value: value,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'IIT-JEE',
                      child: Center(
                        child: Text('IIT-JEE'),
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'CBSE:11-12',
                      child: Center(
                        child: Text('CBSE:11-12'),
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
                            builder: (context) => const BottomNavigation()));
                  },
                  child: const Text('Save')),

                  //  ElevatedButton(
                  // onPressed: () async {
                    
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               Verification()));
                  // },
                  // child: const Text('Go to'))
            ]),
          ),
        ),
      ),
    );
  }
}
