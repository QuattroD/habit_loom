import 'package:flutter/material.dart';
import 'package:habit_loom/Drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_loom/globals.dart' as globals;
var user = FirebaseAuth.instance;
class ALLTASK extends StatefulWidget {
  const ALLTASK({super.key});

  @override
  State<ALLTASK> createState() => _ALLTASKState();
}

class _ALLTASKState extends State<ALLTASK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 76, 142, 93),
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: const Text('Все задачи', style: TextStyle(),),
      ),
      drawer: const DrawerMenu(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Tasks-${user.currentUser!.email.toString()}')
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 76, 142, 93)),
                                        child: Column(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  if (snap[index]
                                                          ['isCompleted'] ==
                                                      'TODO') {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Tasks-${user.currentUser!.email.toString()}')
                                                        .doc(snap[index].id)
                                                        .set({
                                                      'name': snap[index]
                                                          ['name'],
                                                      'task-date': snap[index]
                                                          ['task-date'],
                                                      'task-note': snap[index]
                                                          ['task-note'],
                                                      'remind': snap[index]
                                                          ['remind'],
                                                      'start-time': snap[index]
                                                          ['start-time'],
                                                      'end-time': snap[index]
                                                          ['end-time'],
                                                      'isCompleted': 'Perfect'
                                                    });
                                                  } else if (snap[index]
                                                          ['isCompleted'] ==
                                                      'Perfect') {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Tasks-${user.currentUser!.email.toString()}')
                                                        .doc(snap[index].id)
                                                        .set({
                                                      'name': snap[index]
                                                          ['name'],
                                                      'task-date': snap[index]
                                                          ['task-date'],
                                                      'task-note': snap[index]
                                                          ['task-note'],
                                                      'remind': snap[index]
                                                          ['remind'],
                                                      'start-time': snap[index]
                                                          ['start-time'],
                                                      'end-time': snap[index]
                                                          ['end-time'],
                                                      'isCompleted': 'TODO'
                                                    }
                                                    );
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 30),
                                                  width: 330,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      color:
                                                           Colors.blue,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.blue)),
                                                  child: Center(
                                                      child: snap[index]['isCompleted'] == 'TODO' ? const Text(
                                                          'Закончить задачу',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)) : const Text(
                                                          'Отменить задачу',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))),
                                                )),
                                            InkWell(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'Tasks-${user.currentUser!.email.toString()}')
                                                      .doc(snap[index].id)
                                                      .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
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
                                                onTap: () {
                                                  globals.uid = snap[index].id;
                                                  globals.name =
                                                      snap[index]['name'];
                                                  globals.taskdate =
                                                      snap[index]['task-date'];
                                                  globals.taskNote =
                                                      snap[index]['task-note'];
                                                  globals.Remind =
                                                      snap[index]['remind'];
                                                  globals.timeStart =
                                                      snap[index]['start-time'];
                                                  globals.timeEnd =
                                                      snap[index]['end-time'];
                                                  globals.isCompleted =
                                                      snap[index]
                                                          ['isCompleted'];
                                                  Navigator.popAndPushNamed(
                                                      context, '/edit_task');
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 30),
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
                                                    'Редактировать',
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
                                          left: 10, bottom: 20, top: 15),
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