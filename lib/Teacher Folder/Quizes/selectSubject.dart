import 'package:flutter/material.dart';

import 'createQuiz.dart';

class SelectSubject extends StatefulWidget {
  String teacherEmail;
  SelectSubject({Key? key, required this.teacherEmail}) : super(key: key);
  

  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  String dropdownvalue = 'Maths';

  var items = ['Maths', 'Physics', 'Chemistry'];
  void _cancel() {
    Navigator.pop(context);
  }

 void _submit()  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateQuiz(subject: dropdownvalue, teacherEmail: widget.teacherEmail)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subject'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose the subject', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 26, fontWeight: FontWeight.normal),),
            const SizedBox(height:
            20),
            DropdownButton(
                  // Initial Value
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                   
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                
                  },
                  style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
            ),
           const SizedBox(height:
            20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Back'),
                  onPressed: _cancel,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent
                  ),
                ),
                SizedBox(width: 20,),
                 ElevatedButton(
              child: const Text('Create'),
              onPressed: _submit,
               style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent
                  ),
            ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}