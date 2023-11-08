import 'package:flutter/material.dart';
import 'package:habit_loom/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_loom/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:google_fonts/google_fonts.dart';

var user = FirebaseAuth.instance;
class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  DateTime _selectedDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 76, 142, 93),),
      drawer: const Drawer(child: DrawerMenu()),
      floatingActionButton: FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () {
            Navigator.popAndPushNamed(context, '/create_task');
          },
          backgroundColor: const Color.fromARGB(255, 76, 142, 93),
          child: const Icon(Icons.add)), 
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMMd().format(DateTime.now()), style: const TextStyle(color: Color.fromARGB(255, 184, 184, 184), fontSize: 25,),),
                    const Text('Today', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)
                ]),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color.fromARGB(255, 76, 142, 93),
              locale: 'ru',
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
              dayTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
              monthTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255)
              ),
              onDateChange: (date) {
                _selectedDate = date;
              },
            ),
          )
        ],
      )
    );
  }
}