import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class QuestionAndAnswerPage extends StatefulWidget {
  int count;
  String Quizname;
  QuestionAndAnswerPage({required this.count, required this.Quizname});

  @override
  State<QuestionAndAnswerPage> createState() => _QuestionAndAnswerPageState();
}

class _QuestionAndAnswerPageState extends State<QuestionAndAnswerPage> {
  PageController _pageController = PageController();
  List quizlist = [];
  bool isloading = false;
  String val = 'Next';
  getQuizList() async {
    List results = await DatabaseManager().getQuizans(widget.Quizname);
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

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Scaffold(
            body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(195, 120, 205, 235),
                Color.fromARGB(192, 10, 126, 123)
              ],
            )),
            child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: quizlist.length,
                itemBuilder: ((context, index) {
                  return Center(
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 64, 16, 66),
                              Color.fromARGB(222, 64, 26, 37)
                            ])),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.90,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 255, 250),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text('Question ${index + 1}'))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                    child: Text('Question ${index + 1}: ' +
                                        quizlist[index]['Question']))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: (quizlist[index]['Option 1'] !=
                                          quizlist[index]['Selectedoption'])
                                      ? Color.fromARGB(255, 160, 242, 250)
                                      : ((quizlist[index]['Option 1'] ==
                                                  quizlist[index]
                                                      ['Selectedoption']) &&
                                              (quizlist[index]
                                                      ['Selectedoption'] ==
                                                  quizlist[index]['Answer']))
                                          ? Color.fromARGB(255, 177, 255, 157)
                                          : Color.fromARGB(255, 255, 154, 154),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                        'A. ' + quizlist[index]['Option 1']))),
                            Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: (quizlist[index]['Option 2'] !=
                                          quizlist[index]['Selectedoption'])
                                      ? Color.fromARGB(255, 160, 242, 250)
                                      : ((quizlist[index]['Option 2'] ==
                                                  quizlist[index]
                                                      ['Selectedoption']) &&
                                              (quizlist[index]
                                                      ['Selectedoption'] ==
                                                  quizlist[index]['Answer']))
                                          ? Color.fromARGB(255, 177, 255, 157)
                                          : Color.fromARGB(255, 255, 154, 154),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                        'B. ' + quizlist[index]['Option 2']))),
                            Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: (quizlist[index]['Option 3'] !=
                                          quizlist[index]['Selectedoption'])
                                      ? Color.fromARGB(255, 160, 242, 250)
                                      : ((quizlist[index]['Option 3'] ==
                                                  quizlist[index]
                                                      ['Selectedoption']) &&
                                              (quizlist[index]
                                                      ['Selectedoption'] ==
                                                  quizlist[index]['Answer']))
                                          ? Color.fromARGB(255, 177, 255, 157)
                                          : Color.fromARGB(255, 255, 154, 154),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                        'C. ' + quizlist[index]['Option 3']))),
                            Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: (quizlist[index]['Option 4'] !=
                                          quizlist[index]['Selectedoption'])
                                      ? Color.fromARGB(255, 160, 242, 250)
                                      : ((quizlist[index]['Option 4'] ==
                                                  quizlist[index]
                                                      ['Selectedoption']) &&
                                              (quizlist[index]
                                                      ['Selectedoption'] ==
                                                  quizlist[index]['Answer']))
                                          ? Color.fromARGB(255, 177, 255, 157)
                                          : Color.fromARGB(255, 255, 154, 154),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                        'D. ' + quizlist[index]['Option 4']))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 180, 240, 147),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                  'Correct Answer: ' +
                                      quizlist[index]['Answer'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                            index != quizlist.length - 1
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.deepPurple[600])),
                                    onPressed: () {
                                      _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    child: Text(val),
                                  )
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.deepPurple[600])),
                                    onPressed: () {
                                     
                                      Navigator.of(context).pop();
                                      
                                    },
                                    child: Text('END'),
                                  )
                          ],
                        )),
                  );
                })),
          ))
        : Transform.scale(
            scale: 0.1,
            child: const CircularProgressIndicator(
              color: Colors.white,
              // backgroundColor: Colors.blue.withOpacity(0.2),
              strokeWidth: 20,
            ),
          );
  }

  void _showdialog(int count) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            // // insetAnimationCurve: ,
            // backgroundColor: Color.fromARGB(255, 114, 236, 240),
            title: Text('This is the end\n'
                'Your marks is $count'),

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
