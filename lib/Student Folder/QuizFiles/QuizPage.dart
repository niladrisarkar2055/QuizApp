import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:quizapp/Student%20Folder/LandingPages/BottomNavigation.dart';
import 'package:quizapp/Student%20Folder/LandingPages/StudentProfilePage.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/QuizQuestionCard.dart';

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
  int selectedval = 1;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ourquizName),
      ),
      body: Container(
        child: PageView.builder(
            pageSnapping: true,
            controller: _pageController,
            itemCount: widget.ourquestionList.length,
            itemBuilder: (context, index) {
              final question = widget.ourquestionList[index];

              return buildQuestion(question: question, index: index);
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
            }),
        // child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: widget.ourquestionList.length,
        //     itemBuilder: ((context, index) {

        //       return SingleChildScrollView(
        //         child:Container(
        //         alignment: Alignment.center,
        //         child: QuizQuestionCard(
        //           quizname: widget.ourquizName.toString(),
        //           question:
        //               widget.ourquestionList[index]['Question'].toString(),
        //           option1: widget.ourquestionList[index]['Option 1'].toString(),
        //           option2: widget.ourquestionList[index]['Option 2'].toString(),
        //           option3: widget.ourquestionList[index]['Option 3'].toString(),
        //           option4: widget.ourquestionList[index]['Option 4'].toString(),
        //         ),
        //       )
        //       );

        //     })),
      ),
    );
  }

  Widget buildQuestion({
    @required dynamic question,
    @required int? index,
  }) {
    // int value=1;
    // int selectedval = 1;

    // Future<dynamic> Method(List<String> values) async {
    //   setState(() {
    //     values.add(question['Option 1']);
    //   values.add(question['Option 2']);
    //   values.add(question['Option 3']);
    //   values.add(question['Option 4']);
    //   });
    // }

    List<String> values = [];
    String selectedval = '';
    @override
    void initState() {
      print("Hi this is the question");
      super.initState();
    }

    int value = 1;
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
                  question['Question'],
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ),

          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: Column(
          //     children: values.map((value) {
          //       return Container(
          //         height: 60,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(30),
          //         ),
          //         child: RadioListTile<String>(
          //             tileColor: Colors.green[200],
          //             value: value,
          //             title: Text("New"),
          //             groupValue: selectedval,
          //             onChanged: (value) {
          //               setState(() {
          //                 selectedval = value.toString();
          //               });
          //             }),
          //       );
          //     }).toList(),
          //   ),
          // ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RadioListTile(
                title: Text(question['Option 1']),
                value: 1,
                groupValue: selectedval,
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() {
                    selectedval = val.toString();
                    print("This is selected:" + value.toString());
                  });
                },
              ),
              SizedBox(height: 10),
              RadioListTile(
                title: Text(question['Option 2']),
                value: 2,
                groupValue: selectedval,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    selectedval = value.toString();
                    print("This is selected:" + value.toString());
                  });
                },
              ),
              SizedBox(height: 10),
              RadioListTile(
                title: Text(question['Option 3']),
                value: 3,
                groupValue: selectedval,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    selectedval = value.toString();
                    print("This is selected:" + value.toString());
                  });
                },
              ),
              SizedBox(height: 10),
              RadioListTile(
                title: Text(question['Option 4']),
                value: 4,
                groupValue: selectedval,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    selectedval = value.toString();
                    print("This is selected:" + value.toString());
                  });
                },
              ),
            ],
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
                      //   index! - 1,
                      //   duration: const Duration(milliseconds: 500),
                      //   curve: Curves.easeInOut,
                      // );
                      // index = index !- 1;

                      _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
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
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text('Next'))
            ],
          ),
        ]));
  }
}

















 // return Container(
              //     padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              //     child: Column(children: [
              //       Container(
              //         padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              //         child: Center(
              //           child: Container(
              //             padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              //             height: 140,
              //             width:
              //                 WidgetsBinding.instance.window.physicalSize.width,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Colors.blue[100],
              //             ),
              //             alignment: Alignment.center,
              //             child: Text(
              //               widget.ourquestionList[index]['Question'],
              //               style: TextStyle(fontSize: 15.0),
              //             ),
              //           ),
              //         ),
              //       ),

              //         Container(
              //           child: Column(
              //             children: [
              //               ListTile(
              //                 title: Text(widget.ourquestionList[index]['Option 1']),
              //                 leading: Radio<int>(
              //                     value: 1,
              //                     groupValue: selectedval,
              //                     onChanged: (value) {
              //                       setState(() {
              //                         selectedval = value!;
              //                       });
              //                     }),
              //               ),

              //       ListTile(
              //               title: Text(widget.ourquestionList[index]['Option 2']),
              //               leading: Radio<int>(
              //                   value: 2,
              //                   groupValue: selectedval,
              //                   onChanged: (value) {
              //                     setState(() {
              //                       selectedval = value!;
              //                     });
              //                   }),
              //       ),
              //       ListTile(
              //               title: Text(widget.ourquestionList[index]['Option 3']),
              //               leading: Radio<int>(
              //                   value: 3,
              //                   groupValue: selectedval,
              //                   onChanged: (value) {
              //                     setState(() {
              //                       selectedval = value!;
              //                     });
              //                   }),
              //       ),
              //       ListTile(
              //               title: Text(widget.ourquestionList[index]['Option 4']),
              //               leading: Radio<int>(
              //                   value: 4,
              //                   groupValue: selectedval,
              //                   onChanged: (value) {
              //                     setState(() {
              //                       selectedval = value!;
              //                     });
              //                   }),
              //       ),
              //             ],
              //           ),
              //         ),

              //   ElevatedButton(
              //       onPressed: () {
              //         // if (selectedval == correctans) {
              //         //   CircularProgressIndicator();
              //         //   Navigator.push(
              //         //       context,
              //         //       MaterialPageRoute(
              //         //           builder: (context) => ));
              //         // }
              //       },
              //       child: Text('submit')),
              //   ElevatedButton(onPressed: () {}, child: Text('Next')),
              // ]
              // )
              // );
