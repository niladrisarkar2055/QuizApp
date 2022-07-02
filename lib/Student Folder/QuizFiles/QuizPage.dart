import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Student%20Folder/LandingPages/BottomNavigation.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizQuestionCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';
import 'ResultPage.dart';

class Quizpage extends StatefulWidget {
  List<dynamic> ourquestionList;
  String ourquizName;
  String? ourquizSubject;
  Timestamp ourdateTime;
  String? ourbatch;
  Quizpage({
    required this.ourquestionList,
    required this.ourquizName,
    required this.ourquizSubject,
    required this.ourdateTime,
    required this.ourbatch,
  });

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  String fun(String question, String option1, String option2, String option3,
      String option4) {
    print('this is question-->' + question);
    print('these are options: ' +
        option1 +
        " " +
        option2 +
        " " +
        option3 +
        " " +
        option4);
    return '1';
  }

  final PageController _pageController = PageController();
  String? _value;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _value = " ";
    super.initState();
  }

  double initial = 0.0;

  void update() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        initial = initial + 0.01;
      });
    });
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(widget.ourquizName),
      ),
      body: Container(
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            pageSnapping: true,
            controller: _pageController,
            itemCount: widget.ourquestionList.length,
            itemBuilder: (context, index) {
              final question = widget.ourquestionList[index];

              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 117, 193, 159), Colors.blueGrey],
                )),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                child: Column(children: <Widget>[
                  // Container(
                  //     child: LinearProgressIndicator(
                  //         backgroundColor:
                  //             const Color.fromARGB(255, 108, 153, 175),
                  //         valueColor: const AlwaysStoppedAnimation(
                  //             Color.fromARGB(255, 36, 36, 91)),
                  //         minHeight: 20,
                  //         value: initial)),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: Center(
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        height: 100,
                        width:
                            WidgetsBinding.instance.window.physicalSize.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[100],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Q ${index + 1}." + question['Question'],
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),

                  //options
                  for (int i = 1; i <= 4; i++)
                    Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 254, 206, 244),
                        ),
                        child: Card(

                            // margin: EdgeInsets.all(5),
                            child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          tileColor: Color.fromARGB(255, 254, 206, 244),
                          title: Text(
                            question['Option $i'],
                          ),
                          leading: Radio<String>(
                            value: question['Option $i'],
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;

                                print("Selected value: " + value!);
                              });
                            },
                          ),
                        )),
                      ),
                    ),

                  Container(
                      child: Column(children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(235, 35, 139, 208),
                          onPrimary: const Color.fromARGB(255, 9, 11, 73),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          if (_value == question['Answer']) {
                            setState(() {
                              count = count + 1;
                            });
                            print("This is count:" + count.toString());
                          }

                          // if (index == widget.ourquestionList.length - 1) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               ResultPage(count: count)));

                          //   print("This is count:" + count.toString());
                          // }

                          // update();
                          // setState(() {
                          //   initial = 0.0;
                          // });
                        },
                        child: const Text(
                          'Lock',
                          style: TextStyle(color: Colors.white),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //PREV BUTTON
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              onPressed: () {
                                _pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: const Text('Prev')),
                        ),

                        //NEXT BUTTON
                        const SizedBox(width: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);

                              if (index == widget.ourquestionList.length - 1) {
                                _showdialog(count);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ResultPage(
                                //             Quizname: widget.ourquizName,
                                //             count: count)));

                                final userdata =
                                    FirebaseAuth.instance.currentUser!;
                                DatabaseManager().quizmarks(
                                    widget.ourquizName, count, userdata.uid);
                                print("This is quiz marks" + DatabaseManager()
                                    .fetchquizmarks(widget.ourquizName).toString());
                                print("This is count:" + count.toString());
                              }
                            },
                            child: const Text('Next'))
                      ],
                    ),
                  ])),
                ]),
              );
            }),
      ),
    );
  }

  // QuizQuestionCard(
  //     quizname: widget.ourquizName.toString(),
  //     question:
  //         widget.ourquestionList[index]['Question'].toString(),
  //     option1:
  //         widget.ourquestionList[index]['Option 1'].toString(),
  //     option2:
  //         widget.ourquestionList[index]['Option 2'].toString(),
  //     option3:
  //         widget.ourquestionList[index]['Option 3'].toString(),
  //     option4:
  //         widget.ourquestionList[index]['Option 4'].toString(),
  //     index: index,
  //     controller: _pageController);

  // Widget timerwidget() {
  //   double intial = 0;
  //   update(intial);

  //   // setState(() {
  //   //   initial = 0.0;
  //   // });
  //   return
  //   LinearProgressIndicator(
  //       backgroundColor: const Color.fromARGB(255, 108, 153, 175),
  //       valueColor:
  //           const AlwaysStoppedAnimation(Color.fromARGB(255, 36, 36, 91)),
  //       minHeight: 20,
  //       value: initial);
  // }
  void _showdialog(int count) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            // insetAnimationCurve: ,
            title: Text(
                'Your current marks is $count/${widget.ourquestionList.length}'),
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
}
