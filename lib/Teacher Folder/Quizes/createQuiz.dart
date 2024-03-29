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
  var batchName = ['IIT-JEE', 'CBSE 11-12th'];
   String dropdownvalue = 'IIT-JEE';

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
        widget.teacherEmail, selectedquestion, dateTime, dropdownvalue);
    print("Quizz Created !!");
    Navigator.pop(context);
    Navigator.pop(context);
    
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
      appBar: AppBar(title: const Text('Create Quizz'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 40,
              child: TextField(
                    
                    controller: quizNameController,
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
                        labelText: 'Quiz Name',
                        labelStyle: TextStyle(color:Colors.black26,  fontWeight: FontWeight.bold),
                        ),
                  ),
            ),
             DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: batchName.map((String batchName) {
                return DropdownMenuItem(
                  value: batchName,
                  child: Text(batchName),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              
              },
              style: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('${dateTime.year} / ${dateTime.month} / ${dateTime.day}',
                        style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${dateTime.hour} : ${dateTime.minute}',
                      style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, ),
                    ),
                  ),
                  SizedBox(width: 5),
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
                  onPressed:  _submit,
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