import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/StudentorTeacherPage.dart';


import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherHomePage.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';

class TeacherInfo extends StatefulWidget {
  String email;
  String uID;

  TeacherInfo({Key? key, required this.email, required this.uID})
      : super(key: key);

  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Personal Info'),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white10),
            child: Column(
              children: [
                Text('Welcome ${widget.email} to,', style: TextStyle(color: Colors.black, fontSize: 18)  ),
                Text('SpeEdlabs', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 38, fontWeight: FontWeight.bold),
                ),
                Divider(height: 30, thickness: 3,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              
              decoration: const BoxDecoration(
                  color: Color.fromARGB(164, 124, 77, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(100)
                  )),
              padding: EdgeInsets.all(20),
              child: Column(children: [
                const SizedBox(
                  height: 60,
                ),
                
               
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    
                    controller: subjectController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.deepPurpleAccent, style: BorderStyle.solid)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: Colors.greenAccent, style: BorderStyle.solid)
                        ),
                        labelText: 'Subject',
                        labelStyle: TextStyle(color:Color.fromARGB(255, 255, 255, 255),  fontWeight: FontWeight.bold),
                        ),
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
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.deepPurpleAccent, style: BorderStyle.solid)
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: numberController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.deepPurpleAccent, style: BorderStyle.solid)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          DatabaseManager().createTeacher(
                              widget.email,
                              nameController.text.trim(),
                              widget.uID,
                              numberController.text.trim(),
                              subjectController.text.trim());
                          DatabaseManager().createTUser(widget.email, "Teacher");
                     
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeacherHomePage(
                                      teacherEmail: widget.email,
                                      teacherUid: widget.uID)));
                        },
                        child: const Text('Save'),
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.white

                            
                        ),),
                        
                        SizedBox(width: 20,),
                        ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Verification()));
                    },
                    child: const Text('Go to'),
                     style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.white

                            
                        ),)
                  ],
                ),
                
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
                    
                    // for (int i = 1; i < 11; i++) {
                    //   DatabaseManager().createquestion(
                    //       'Maths',
                    //       'Question $i',
                    //       'option1',
                    //       'option2',
                    //       'option3',
                    //       'option4',
                    //       'answer');
                    // }
                    