import 'dart:ffi';

import 'package:flutter/material.dart';

import '../Services/Teacher_DatabaseManager.dart';

class QuizReportTeacher extends StatefulWidget {
  String quizName;
  String quizSubject;
  QuizReportTeacher({Key? key, required this.quizName, required this.quizSubject}) : super(key: key);

  @override
  State<QuizReportTeacher> createState() => _QuizReportTeacherState();
}

class _QuizReportTeacherState extends State<QuizReportTeacher> {
  List QuizMarks = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllMarks();
  }

  fetchAllMarks() async {
    QuizMarks = await DatabaseManager().getAllMarks(widget.quizName);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 3,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.4), BlendMode.dstATop),
                image: AssetImage('assets/${widget.quizSubject}.jpg'),
                fit: BoxFit.cover,
              )),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(widget.quizName.toUpperCase(),
                        style: TextStyle(
                            backgroundColor: Colors.white70,
                            fontSize: 40,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold)),
                    Text('Quiz Report',
                        style: TextStyle(
                            backgroundColor: Colors.white70,
                            fontSize: 40,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Divider(
              height: 20,
              color: Color.fromARGB(183, 115, 66, 250),
              thickness: 6,
            ),
            QuizMarks.length > 0
                ? ListView.builder(
                    itemCount: QuizMarks.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shadowColor: Color.fromARGB(255, 213, 200, 249),
                        margin: EdgeInsets.all(10),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 1)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.wine_bar_rounded,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text((index + 1).toString() + '.'),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              QuizMarks[index]['StudentEmail'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "Marks: ${QuizMarks[index]['Marks']}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                              ]),
                        ),
                      );
                    })
                : Center(
                    child: Container(
                        child: Text('No one have attempted the quiz yet!')),
                  ),
          ],
        ),
      ),
    );
  }
}