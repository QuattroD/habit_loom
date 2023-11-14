import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as globals;

TextEditingController taskNameEdit = TextEditingController();
TextEditingController taskNoteEdit = TextEditingController();
TextEditingController dateCreateEdit = TextEditingController();
TextEditingController startTimeEdit = TextEditingController();
TextEditingController endTimeEdit = TextEditingController();
List<int> remindListEdit = [5, 10, 15, 20];
int _selectedRemindEdit = globals.Remind;
var user = FirebaseAuth.instance;
CollectionReference task = FirebaseFirestore.instance.collection('Tasks-${user.currentUser!.email.toString()}');


class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
       taskNameEdit.text = globals.name;
       taskNoteEdit.text = globals.taskNote;
       dateCreateEdit.text = globals.taskdate;
       startTimeEdit.text = globals.timeStart;
       endTimeEdit.text = globals.timeEnd;
       _selectedRemindEdit = globals.Remind;
  });
  }

  String taskdate = globals.taskdate;
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 142, 93),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              setState(() {
                taskNameEdit.text = '';
                dateCreateEdit.text = '';
                taskNoteEdit.text = '';
                startTimeEdit.text = '';
                endTimeEdit.text = '';
              });
              Navigator.pushNamed(context, '/home');
            },
          ),
          actions: [
            IconButton(icon: const Icon(Icons.check), onPressed: () {
              FirebaseFirestore.instance.collection('Tasks-${user.currentUser!.email.toString()}').doc(globals.uid).set({
                'name': taskNameEdit.text,
                'task-date': dateCreateEdit.text,
                'task-note': taskNoteEdit.text,
                'remind': _selectedRemindEdit,
                'start-time': startTimeEdit.text,
                'end-time': endTimeEdit.text,
                'isCompleted': globals.isCompleted
              });
              setState(() {
                taskNameEdit.text = '';
                dateCreateEdit.text = '';
                taskNoteEdit.text = '';
                startTimeEdit.text = '';
                endTimeEdit.text = '';
              });
              Navigator.popAndPushNamed(context, '/home');
            })
          ],
          title: const Text(
            'Изменение задачи',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Center(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: TextField(
                    controller: taskNameEdit,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    cursorColor: const Color.fromARGB(255, 233, 241, 243),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050));
                      if(date != null) {
                        setState(() {
                          dateCreateEdit.text = DateFormat.yMd().format(date);
                        });
                      }
                    },
                    controller: dateCreateEdit,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    cursorColor: const Color.fromARGB(255, 233, 241, 243),
                    decoration: InputDecoration(
                      hintText: "🗓️ Выберите дату",
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextField(
                controller: taskNoteEdit,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                cursorColor: const Color.fromARGB(255, 233, 241, 243),
                decoration: InputDecoration(
                  hintText: "📃 Описание задачи",
                  hintStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 76, 142, 93))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 76, 142, 93))),
                ),
              ),
            ),
            SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? start = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(start != null) {
                        setState(() {
                          startTimeEdit.text = '${start.hour}:${start.minute}';
                        });
                      }
                    },
                    controller: startTimeEdit,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    cursorColor: const Color.fromARGB(255, 233, 241, 243),
                    decoration: InputDecoration(
                      hintText: "⌛ Начало",
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                    ),
                  ),
                ),
                SizedBox(
              width: MediaQuery.of(context).size.height * 0.02,
            ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? end = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(end != null) {
                        setState(() {
                          endTimeEdit.text = '${end.hour}:${end.minute}';
                        });
                      }
                    },
                    controller: endTimeEdit,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    cursorColor: const Color.fromARGB(255, 233, 241, 243),
                    decoration: InputDecoration(
                      hintText: "⌛ Конец",
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 76, 142, 93))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: DropdownButtonFormField(
                dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                borderRadius: BorderRadius.circular(15),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 76, 142, 93), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 76, 142, 93), width: 1),
                    ),
                    hintText: "⌚ Напомнить",
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemindEdit = int.parse(newValue!);
                    });
                  },
                  items: remindListEdit.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text('⌚ Напомнить за ${value.toString()} минут', style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      );
                    },
                  ).toList()),
            ),
              ],
            ),          
          ),
        );
  }
}