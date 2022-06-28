import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuizQuestionCard extends StatefulWidget {
  String quizname;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  int index;
  PageController controller;

  QuizQuestionCard(
      {required this.quizname,
      required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.index,
      required this.controller});

  @override
  State<QuizQuestionCard> createState() => _QuizQuestionCardState();
}

class _QuizQuestionCardState extends State<QuizQuestionCard> {
  Future<dynamic> Method(List<String> values) async {
    values.add(widget.option1);
    values.add(widget.option2);
    values.add(widget.option3);
    values.add(widget.option4);
  }

  
  List<String> values = [];
  String selectedval = '';

  int value = 1;

  @override
  void initState() {
    Method(values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                height: 140,
                width: WidgetsBinding.instance.window.physicalSize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[100],
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.question,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: values.map((value) {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: RadioListTile<String>(
                      tileColor: Colors.green[200],
                      value: value,
                      title: Text(value),
                      groupValue: selectedval,
                      onChanged: (value) {
                        setState(() {
                          selectedval = value.toString();
                        });
                      }),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(235, 35, 139, 208),
                onPrimary: Color.fromARGB(255, 9, 11, 73),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {},
              child: Text(
                'submit',
                style: TextStyle(color: Colors.white),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                      // _pageController.animateToPage(
                      //   widget.index - 1,
                      //   duration: const Duration(milliseconds: 1000),
                      //   curve: Curves.easeInOut,
                      // );
                      // index = index - 1;
                    },
                    child: Text('Prev')),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    // _pageController.nextPage(
                    //     duration: Duration(milliseconds: 1000),
                    //     curve: Curves.easeIn);
                  },
                  child: Text('Next'))
            ],
          ),
        ]));
  }
}
