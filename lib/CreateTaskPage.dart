import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

TextEditingController taskName = TextEditingController();
TextEditingController taskNote = TextEditingController();
TextEditingController dateCreate = TextEditingController();
TextEditingController startTime = TextEditingController();
TextEditingController endTime = TextEditingController();
int _selectedRemind = 5;
List<int> remindList = [5, 10, 15, 20];

var user = FirebaseAuth.instance;

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
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
                taskName.text = '';
                dateCreate.text = '';
                taskNote.text = '';
                startTime.text = '';
                endTime.text = '';
              });
              Navigator.pushNamed(context, '/home');
            },
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Tasks-${user.currentUser!.email.toString()}')
                      .add({
                    'name': taskName.text,
                    'task-date': dateCreate.text,
                    'task-note': taskNote.text,
                    'remind': _selectedRemind,
                    'start-time': startTime.text,
                    'end-time': endTime.text
                  });
                  setState(() {
                    taskName.text = '';
                    dateCreate.text = '';
                    taskNote.text = '';
                    startTime.text = '';
                    endTime.text = '';
                  });
                  Navigator.popAndPushNamed(context, '/home');
                })
          ],
          title: const Text(
            'Новая задача',
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
                    controller: taskName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    cursorColor: const Color.fromARGB(255, 233, 241, 243),
                    decoration: InputDecoration(
                      hintText: "🎯 Название задачи",
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
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050));
                      if(date != null) {
                        setState(() {
                          dateCreate.text = DateFormat.yMd().format(date);
                        });
                      }
                    },
                    controller: dateCreate,
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
                controller: taskNote,
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
                          startTime.text = '${start.hour}:${start.minute}';
                        });
                      }
                    },
                    controller: startTime,
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
                          endTime.text = '${end.hour}:${end.minute}';
                        });
                      }
                    },
                    controller: endTime,
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
                          color: Color.fromARGB(255, 76, 142, 93), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 76, 142, 93), width: 2),
                    ),
                    hintText: "⌚ Напомнить",
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text('⌚ Напомнить за ${value.toString()} минут', style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      );
                    },
                  ).toList()),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ]),
        ));
  }
}
