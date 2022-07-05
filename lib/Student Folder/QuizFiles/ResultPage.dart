import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizapp/Student%20Folder/Services/Databasemanager.dart';

class ResultPage extends StatefulWidget {
  int count;
  String Quizname;
  ResultPage({required this.count, required this.Quizname});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List quizlist = [];
  bool isloading = false;
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
    return isloading?Scaffold(
        appBar: AppBar(
          title: Text(widget.Quizname),
        ),
        body: Container(
           decoration: const BoxDecoration(
                     gradient: LinearGradient(colors: [
                      Color.fromARGB(195, 120, 205, 235),Color.fromARGB(192, 10, 126, 123)
                      
                    ],)),
          child: ListView.builder(
              itemCount: quizlist.length,
              itemBuilder: ((context, index) {
                return Container(
                  child: Column(
                    children: [
                      Text(quizlist[index]['Question']),
                      Container(
                        color: Color.fromARGB(255, 212, 197, 140),
                        child: Column(
                          children: [
                            Card(
                              color: quizlist[index]['Option 1']==quizlist[index]['Selectedoption']?Colors.green:Colors.amberAccent,
                              child: Text(quizlist[index]['Option 1']),
                            ),
                            Card(
                              color: quizlist[index]['Option 2']==quizlist[index]['Selectedoption']?Colors.green:Colors.amberAccent,
                              child: Text(quizlist[index]['Option 2']),
                            ),
                            Card(
                              color: quizlist[index]['Option 3']==quizlist[index]['Selectedoption']?Colors.green:Colors.amberAccent,
                              child: Text(quizlist[index]['Option 3']),
                            ),
                            Card(
                              color: quizlist[index]['Option 4']==quizlist[index]['Selectedoption']?Colors.green:Colors.amberAccent,
                              child: Text(quizlist[index]['Option 4']),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
        )

        //  Row(children: [
        //   widget.count == -1
        //       ? Text('You have not attempted the quiz')
        //       : Text(
        //           "You marks is " + widget.count.toString(),
        //         )
        // ]),

        ):
        Transform.scale(
        scale: 0.1,
        child: CircularProgressIndicator(
        color: Colors.white,
        // backgroundColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 20,
  ),
);
  }
}
