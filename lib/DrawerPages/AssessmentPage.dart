import 'package:flutter/material.dart';
import 'package:habit_loom/Drawer.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => AassessmentStatePage();
}

class AassessmentStatePage extends State<AssessmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 76, 142, 93),
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: const Text('Статистика', style: TextStyle(),),
      ),
      drawer: const DrawerMenu(),
      body: Container(
          
    ),
    );
  }
}