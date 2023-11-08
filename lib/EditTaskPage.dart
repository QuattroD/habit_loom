import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;

TextEditingController taskNameEdit = TextEditingController();
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
  });
  }

  bool monday = globals.monday;
  bool tuesday = globals.tuesday;
  bool wednesday = globals.wednesday;
  bool thursday = globals.thursday;
  bool friday = globals.friday;
  bool saturday = globals.saturday;
  bool sunday = globals.sunday;
  bool _repeat = true;
  bool morning = globals.morning;
  bool day = globals.day;
  bool night = globals.night;
  bool difference = true;
  double percent = globals.percent;
  String dataCreate = DateTime.now().toString();
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
              });
              Navigator.pushNamed(context, '/home');
            },
          ),
          actions: [
            IconButton(icon: const Icon(Icons.check), onPressed: () {
              FirebaseFirestore.instance.collection('Tasks-${user.currentUser!.email.toString()}').doc(globals.uid).set({
                'name' : taskNameEdit.text.toString(),
                'monday' : monday,
                'tuesday' : tuesday,
                'wednesday' : wednesday,
                'thursday' : thursday,
                'friday' : friday,
                'saturday' : saturday,
                'sunday' : sunday,
                'morning' : morning,
                'day' : day,
                'night' : night,
                'percent' : percent,
                'task-date' : dataCreate,
              });
              setState(() {
                taskNameEdit.text = '';
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
                  width: MediaQuery.of(context).size.width * 0.8,
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
            Row(
              children: [
                SizedBox(
                    child: Row(
                  children: [
                    const Text(
                      'Повторять каждый день',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                        fillColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 76, 142, 93)),
                        value: _repeat,
                        onChanged: (value) {
                          setState(() {
                            _repeat = value!;
                            if (_repeat == true) {
                              monday = true;
                              tuesday = true;
                              wednesday = true;
                              thursday = true;
                              friday = true;
                              saturday = true;
                              sunday = true;
                            } else {
                              monday = true;
                              tuesday = false;
                              wednesday = false;
                              thursday = false;
                              friday = false;
                              saturday = false;
                              sunday = false;
                            }
                          });
                        })
                  ],
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                FloatingActionButton(
                  heroTag: 'btn_monday',
                  onPressed: () {
                    setState(() {
                      if (monday == false) {
                        monday = true;
                      } else {
                        monday = false;
                      }
                    });
                  },
                  backgroundColor: monday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'П',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                FloatingActionButton(
                  heroTag: 'btn_tuesday',
                  onPressed: () {
                    setState(() {
                      if (tuesday == false) {
                        tuesday = true;
                      } else {
                        tuesday = false;
                      }
                    });
                  },
                  backgroundColor: tuesday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'В',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                FloatingActionButton(
                  heroTag: 'btn_wednesday',
                  onPressed: () {
                    setState(() {
                      if (wednesday == false) {
                        wednesday = true;
                      } else {
                        wednesday = false;
                      }
                    });
                  },
                  backgroundColor: wednesday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'С',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                FloatingActionButton(
                  heroTag: 'btn_thursday',
                  onPressed: () {
                    setState(() {
                      if (thursday == false) {
                        thursday = true;
                      } else {
                        thursday = false;
                      }
                    });
                  },
                  backgroundColor: thursday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'Ч',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                FloatingActionButton(
                  heroTag: 'btn_friday',
                  onPressed: () {
                    setState(() {
                      if (friday == false) {
                        friday = true;
                      } else {
                        friday = false;
                      }
                    });
                  },
                  backgroundColor: friday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'П',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                FloatingActionButton(
                  heroTag: 'btn_saturday',
                  onPressed: () {
                    setState(() {
                      if (saturday == false) {
                        saturday = true;
                      } else {
                        saturday = false;
                      }
                    });
                  },
                  backgroundColor: saturday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'С',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                FloatingActionButton(
                  heroTag: 'btn_sunday',
                  onPressed: () {
                    setState(() {
                      if (sunday == false) {
                        sunday = true;
                      } else {
                        sunday = false;
                      }
                    });
                  },
                  backgroundColor: sunday
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
                  child: const Text(
                    'В',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            SizedBox(
                    child: Row(
                  children: [
                    const Text(
                      'Один раз в любое время',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                        fillColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 76, 142, 93)),
                        value: difference,
                        onChanged: (value) {
                          setState(() {
                            difference = value!;
                            if (difference == true) {
                              morning = true;
                              day = true;
                              night = true;
                            } else {
                              morning = false;
                              day = false;
                              night = false;
                            }
                          });
                        })
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
              width: 120, 
              height: 60, 
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: morning
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (morning == false) {
                      morning = true;
                    } else {
                      morning = false;
                    }
                  });
                },
                child: const Center(
                  child: Text(
                    'Утро',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15,),
            Container(
              width: 120, 
              height: 60, 
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: day
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (day == false) {
                      day = true;
                    } else {
                      day = false;
                    }
                  });
                },
                child: const Center(
                  child: Text(
                    'День',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15,),
            Container(
              width: 120, 
              height: 60, 
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: night
                      ? const Color.fromARGB(255, 76, 142, 93)
                      : Colors.grey,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (night == false) {
                      night = true;
                    } else {
                      night = false;
                    }
                  });
                },
                child: const Center(
                  child: Text(
                    'Вечер',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
              ],
            ),
          ]),
        ));
  }
}