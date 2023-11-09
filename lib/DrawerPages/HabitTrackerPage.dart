import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:habit_loom/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_loom/globals.dart' as globals;
import 'package:intl/intl.dart';

var user = FirebaseAuth.instance;
var currentDate = DateFormat.yMd().format(DateTime.now());

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      // appBar: AppBar(),
      appBar: CalendarAppBar(
          fullCalendar: false,
          locale: 'ru',
          accent: const Color.fromARGB(255, 76, 142, 93),
          onDateChanged: (value) {
            currentDate = DateFormat.yMd().format(value);
            print(currentDate);
          },
          firstDate: DateTime.now().subtract(const Duration(days: 140)),
          lastDate: DateTime.now()),
      drawer: const Drawer(child: DrawerMenu()),
      floatingActionButton: FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () {
            Navigator.popAndPushNamed(context, '/create_task');
          },
          backgroundColor: const Color.fromARGB(255, 76, 142, 93),
          child: const Icon(Icons.add)), 
          body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Tasks-${user.currentUser!.email.toString()}').where('task-date', isEqualTo: currentDate.toString()).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Color.fromARGB(255, 76, 142, 93),),
              );
            }
            var snap = snapshot.data!.docs;
            return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        const Padding(padding: EdgeInsets.only(right: 7,)),
                        SlidableAction(onPressed: ((context) {}),
                        icon: Icons.skip_next,
                        backgroundColor: Colors.blue,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),),
                        const Padding(padding: EdgeInsets.only(left: 7,)),
                        SlidableAction(onPressed: ((context) {
                          globals.uid = snap[index].id;
                          globals.name = snap[index]['name'];
                          globals.taskdate = snap[index]['task-date'];
                          globals.taskNote = snap[index]['task-note'];
                          globals.Remind = snap[index]['remind'];
                          globals.timeStart = snap[index]['start-time'];
                          globals.timeEnd = snap[index]['end-time'];
                          Navigator.popAndPushNamed(context, '/edit_task');
                        }),
                        icon: Icons.edit,
                        // label: 'Редактировать',
                        backgroundColor: Colors.purple,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),),
                        const Padding(padding: EdgeInsets.only(left: 7,)),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        const Padding(padding: EdgeInsets.only(right: 7,)),
                        SlidableAction(onPressed: ((context) {}),
                        icon: Icons.check,   
                        // label: 'Выполнено',
                        backgroundColor: Colors.green,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.only(top: 15),
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 76, 142, 93),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: ListTile(
                            title: Text(snap[index]['name'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30)),
                            subtitle: Row(
                              children: [
                                Text(snap[index]['task-note'], style: const TextStyle(color: Colors.white, fontSize: 20),)
                              ],
                            )
                          )));
                });
          }),
    );
  }
}