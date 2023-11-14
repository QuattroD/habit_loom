import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
      appBar: CalendarAppBar(
          fullCalendar: true,
          locale: 'ru',
          accent: const Color.fromARGB(255, 76, 142, 93),
          onDateChanged: (value) {
            setState(() {
              currentDate = DateFormat.yMd().format(value);
            });
            print(currentDate);
          },
          firstDate: DateTime.now().subtract(const Duration(days: 140)),
          selectedDate: DateTime.now(),
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
          stream: FirebaseFirestore.instance
              .collection('Tasks-${user.currentUser!.email.toString()}')
              .where('task-date', isEqualTo: currentDate.toString())
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 76, 142, 93),
                ),
              );
            }
            var snap = snapshot.data!.docs;
            return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                            child: Slidable(
                                startActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(
                                      right: 7,
                                    )),
                                    SlidableAction(
                                      onPressed: ((context) {}),
                                      icon: Icons.skip_next,
                                      backgroundColor: Colors.blue,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(
                                      left: 7,
                                    )),
                                    SlidableAction(
                                      onPressed: ((context) {
                                        globals.uid = snap[index].id;
                                        globals.name = snap[index]['name'];
                                        globals.taskdate =
                                            snap[index]['task-date'];
                                        globals.taskNote =
                                            snap[index]['task-note'];
                                        globals.Remind = snap[index]['remind'];
                                        globals.timeStart =
                                            snap[index]['start-time'];
                                        globals.timeEnd =
                                            snap[index]['end-time'];
                                        globals.isCompleted =
                                            snap[index]['isCompleted'];
                                        Navigator.popAndPushNamed(
                                            context, '/edit_task');
                                      }),
                                      icon: Icons.edit,
                                      backgroundColor: Colors.purple,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(
                                      left: 7,
                                    )),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(
                                      right: 7,
                                    )),
                                    SlidableAction(
                                      onPressed: ((context) {
                                        if (snap[index]['isCompleted'] ==
                                            'TODO') {
                                          FirebaseFirestore.instance
                                              .collection(
                                                  'Tasks-${user.currentUser!.email.toString()}')
                                              .doc(snap[index].id)
                                              .set({
                                            'name': snap[index]['name'],
                                            'task-date': snap[index]
                                                ['task-date'],
                                            'task-note': snap[index]
                                                ['task-note'],
                                            'remind': snap[index]['remind'],
                                            'start-time': snap[index]
                                                ['start-time'],
                                            'end-time': snap[index]['end-time'],
                                            'isCompleted': 'Perfect'
                                          });
                                        } else if (snap[index]['isCompleted'] ==
                                            'Perfect') {
                                          FirebaseFirestore.instance
                                              .collection(
                                                  'Tasks-${user.currentUser!.email.toString()}')
                                              .doc(snap[index].id)
                                              .set({
                                            'name': snap[index]['name'],
                                            'task-date': snap[index]
                                                ['task-date'],
                                            'task-note': snap[index]
                                                ['task-note'],
                                            'remind': snap[index]['remind'],
                                            'start-time': snap[index]
                                                ['start-time'],
                                            'end-time': snap[index]['end-time'],
                                            'isCompleted': 'TODO'
                                          });
                                        }
                                      }),
                                      icon: snap[index]['isCompleted'] == 'TODO'
                                          ? Icons.check
                                          : Icons.change_circle_outlined,
                                      backgroundColor:
                                          snap[index]['isCompleted'] == 'TODO'
                                              ? Colors.green
                                              : Colors.orange,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Scaffold.of(context).showBottomSheet<void>(
                                        (BuildContext context) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 76, 142, 93)),
                                        child: Column(
                                          children: [
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.only(top: 30),
                                                  width: 330,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 33, 33, 243),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              33, 33, 243))),
                                                  child: const Center(
                                                      child: Text(
                                                          'Задача выполнена',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))),
                                                )),
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.only(top: 10),
                                                  height: 50,
                                                  width: 330,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: Colors.red,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.red)),
                                                  child: const Center(
                                                      child: Text(
                                                    'Удалить задачу',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                )),
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.only(top: 30),
                                                  width: 330,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.white)),
                                                  child: const Center(
                                                      child: Text(
                                                    'Закрыть',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                )),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, bottom: 20),
                                      padding: const EdgeInsets.all(15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 76, 142, 93),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snap[index]['name'],
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${snap[index]['start-time']} - ${snap[index]['end-time']}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              RotatedBox(
                                                quarterTurns: 1,
                                                child: Text(
                                                  '${snap[index]['isCompleted']}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            snap[index]['task-note'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )),
                                ))),
                      ));
                });
          }),
    );
  }
}
