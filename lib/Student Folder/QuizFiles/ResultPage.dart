import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResultPage extends StatefulWidget {
  int count;
  String Quizname;
  ResultPage({required this.count, required this.Quizname});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        child: ListTile(
          tileColor: Colors.amber,
          title: Text(widget.count.toString()),
          subtitle:  Text('Your marks in: '+ widget.Quizname),
        ),
      ),
    );
  }
}
