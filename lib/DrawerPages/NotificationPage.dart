import 'package:flutter/material.dart';
import 'package:habit_loom/Drawer.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 76, 142, 93),
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: const Text('Уведомления', style: TextStyle(),),
      ),
      drawer: const DrawerMenu(),
    );
  }
}