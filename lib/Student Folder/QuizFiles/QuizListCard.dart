// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizPage.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

import 'ResultPage.dart';

class QuizcardStudentSide extends StatefulWidget {
  List<dynamic> questionList;
  String quizName;
  String quizSubject;
  Timestamp dateTime;
  String batch;
  QuizcardStudentSide(
      {required this.batch,
      required this.dateTime,
      required this.questionList,
      required this.quizName,
      required this.quizSubject});

  @override
  State<QuizcardStudentSide> createState() => _QuizcardStudentSideState();
}

class _QuizcardStudentSideState extends State<QuizcardStudentSide> {
  DatabaseManager databaseManager = new DatabaseManager();

  //onclick a chatroom is created and user is taken to the messagebox is inside
  void _showdialog(int count) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            // // insetAnimationCurve: ,
            // backgroundColor: Color.fromARGB(255, 114, 236, 240),
            title: Text('Your marks is $count'),
            content: Text('Click for more info'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back'),
              )
            ],
          );
        });
  }

  //for fetching total marks
  List quizlist = [];
  bool isloading = false;
  getQuizList() async {
    List results = await DatabaseManager().getQuizans(widget.quizName);
    print('This is quizz List');
    // print(results);

    for (int i = 0; i < results.length; i++) {
      {
        quizlist.add(results[i]);
      }
    }

    if (mounted) {
      setState(() {
        isloading = true;
      });
    }
    return quizlist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuizList();
  }

  bool attention = false;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(colors: [
    //                   Color.fromARGB(194, 121, 160, 205),Color.fromARGB(222, 248, 173, 220)

    //                 ],),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: GestureDetector(
    //     onTap: () async {
    //       setState(() {
    //         attention = !attention;
    //       });
    //       int marks = await DatabaseManager().fetchquizmarks(widget.quizName);
    //       if (marks >= 0) {
    //         _showdialog(marks);
    //       } else {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => Quizpage(
    //                 ourquestionList: widget.questionList,
    //                 ourquizName: widget.quizName,
    //                 ourquizSubject: widget.quizSubject,
    //                 ourdateTime: widget.dateTime,
    //                 ourbatch: widget.batch,
    //               ),
    //             ));
    //       }
    //       // print('This is questions --->  ');
    //       // print(widget.questionList);
    //       // print(widget.quizName);
    //       // print(widget.quizSubject);
    //       // }
    //     },
    //     child: Container(
    //       padding:
    //           const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    //       child: Row(
    //         children: <Widget>[
    //           Expanded(
    //             child: Row(
    //               children: <Widget>[
    //                 Text(
    //                     "${widget.dateTime.toDate().day}/${widget.dateTime.toDate().month}"),
    //                 const SizedBox(
    //                   width: 16,
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     color: Colors.transparent,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text(
    //                           widget.quizName,
    //                           style: TextStyle(
    //                               fontSize: 16,
    //                               color: Color.fromARGB(255, 255, 255, 255),
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                         const SizedBox(
    //                           height: 6,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 30,
    //                 ),
    //                 Text(
    //                     "${widget.dateTime.toDate().hour}:${widget.dateTime.toDate().minute}"),
    //                 SizedBox(
    //                   width: 30,
    //                 ),
    //                 Text(widget.batch)
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    //   return Card(
    //     color: Colors.transparent,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(20),
    //       child: Material(
    //         child: InkWell(

    //           // highlightColor: Colors.orange.withOpacity(0.3),
    //           // splashColor: Color.fromARGB(255, 8, 7, 7).withOpacity(0.3),
    //           onTap: () async {
    //             int marks =
    //                 await DatabaseManager().fetchquizmarks(widget.quizName);
    //             // ResultPage(count:marks,Quizname:widget.quizName!);
    //             //       setState(() {
    //             //    attention = !attention;
    //             //       });

    //             if (marks == -1) {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => Quizpage(
    //                       ourquestionList: widget.questionList,
    //                       ourquizName: widget.quizName!,
    //                       ourquizSubject: widget.quizSubject,
    //                       ourdateTime: widget.dateTime,
    //                       ourbatch: widget.batch,
    //                     ),
    //                   ));
    //             }
    //             else{
    //                Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => ResultPage(count:marks,Quizname:widget.quizName)
    //             ));
    //             }

    //           },
    //           child: Ink(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Center(
    //                   child: Icon( Icons.quiz_rounded, size: 70, ),
    //                 ),
    //                 Center(
    //                   child: Text(
    //                     widget.quizName,

    //                     style: TextStyle(

    //                       fontSize: 30,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.blue[400],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             // color: Colors.amberAccent.withOpacity(0.2),
    //             // height: 200,
    //             // width: 19,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return Card(
      borderOnForeground: attention,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () async {
            int marks = await DatabaseManager().fetchquizmarks(widget.quizName);
          
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResultPage(count: marks, Quizname: widget.quizName)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

             
              Container(
                padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                 
                ),
                child: Image.asset('assets/speedlabsLogo.png', height: 100, width:  100,)),
              // Icon( Icons.quiz_rounded, size: 70,color: Color.fromARGB(255, 43, 42, 39), ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(195, 235, 199, 120),
                      Color.fromARGB(192, 126, 81, 10)
                    ],
                  ),
                ),
                margin: EdgeInsets.all(2),
                // color: Color.fromARGB(255, 67, 116, 84),
                child: Text(
                  widget.quizName,
                  style: TextStyle(
                      decorationColor: Colors.blue[200],
                      fontFamily: 'RobotoMono',
                      fontSize: 25,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
