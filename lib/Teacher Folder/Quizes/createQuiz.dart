import 'package:flutter/material.dart';
import 'package:quizapp/Teacher%20Folder/LandingPages/TeacherHomePage.dart';
import 'package:quizapp/Teacher%20Folder/Services/Teacher_DatabaseManager.dart';


class CreateQuiz extends StatefulWidget {
  String subject;
  String teacherEmail;
  CreateQuiz({Key? key, required this.teacherEmail, required this.subject})
      : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  List<dynamic> questionList = [];
  List<dynamic> selectedquestion = [];
  TextEditingController quizNameController = TextEditingController();
  DateTime dateTime = DateTime(2022, 6, 22, 12, 0);

  void _itemChange(dynamic itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedquestion.add(itemValue);
      } else {
        selectedquestion.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  _submit() {
    DatabaseManager().createQuiz(quizNameController.text.trim(), widget.subject,
        widget.teacherEmail, selectedquestion, dateTime);
    print("Quizz Created !!");
  }

  Future pickDateTime() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
    if (time == null) return;

    final dateTIME =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      dateTime = dateTIME;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuestionList(widget.subject);
  }

  fetchQuestionList(String subject) async {
    if (subject == "Maths") {
      dynamic results = await DatabaseManager().getMathsQuestionList();
      setState(() {
        questionList = results;
      });
    }
    if (subject == "Physics") {
      dynamic results = await DatabaseManager().getPhysicsQuestionList();
      setState(() {
        questionList = results;
      });
    }
    if (subject == "Chemistry") {
      dynamic results = await DatabaseManager().getChemistryQuestionList();
      setState(() {
        questionList = results;
      });
    }
    return questionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quizz')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 40,
              child: TextField(
                style: const TextStyle(height: 2.0),
                controller: quizNameController,
                decoration: const InputDecoration(
                    hintText: 'Quizz Name', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              child: Row(
                children: [
                  Text('${dateTime.year} / ${dateTime.month} / ${dateTime.day}',
                      style: TextStyle(backgroundColor: Colors.blue)),
                  SizedBox(width: 10),
                  Text(
                    '${dateTime.hour} : ${dateTime.minute}',
                    style: TextStyle(backgroundColor: Colors.blue),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () async {
                        pickDateTime();
                       
                      },
                      child: Text("Schedule"))
                ],
              ),
            ),
            SingleChildScrollView(
              child: ListBody(
                children: questionList
                    .map((question) => CheckboxListTile(
                          value: selectedquestion.contains(question),
                          title: Text(question['Question']),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) =>
                              _itemChange(question, isChecked!),
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _cancel,
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed:_submit,
                    
                  child: const Text('Submit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}