import 'package:flutter/material.dart';
import 'package:habit_loom/Drawer.dart';

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
    );
  }
}