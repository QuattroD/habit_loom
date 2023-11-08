import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController taskName = TextEditingController();
var user = FirebaseAuth.instance;

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = true;
  bool sunday = true;
  bool _repeat = true;
  bool morning = true;
  bool day = true;
  bool night = true;
  bool difference = true;
  double percent = 0;
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
                taskName.text = '';
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
                    // 'ID' :
                    'name': taskName.text,
                    'monday': monday,
                    'tuesday': tuesday,
                    'wednesday': wednesday,
                    'thursday': thursday,
                    'friday': friday,
                    'saturday': saturday,
                    'sunday': sunday,
                    'morning': morning,
                    'day': day,
                    'night': night,
                    'percent': percent,
                    'task-date': dataCreate,
                  });
                  setState(() {
                    taskName.text = '';
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
                  width: MediaQuery.of(context).size.width * 0.8,
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
                        if (difference == false) {
                          morning = true;
                          day = false;
                          night = false;
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
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
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
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
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
                            fontWeight: FontWeight.bold),
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