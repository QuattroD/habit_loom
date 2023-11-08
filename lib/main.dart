import 'package:flutter/material.dart';
import 'package:habit_loom/CreateTaskPage.dart';
import 'package:habit_loom/DrawerPages/All_TaskPage.dart';
import 'package:habit_loom/DrawerPages/AssessmentPage.dart';
import 'package:habit_loom/AuthPage.dart';
import 'package:habit_loom/DrawerPages/NotificationPage.dart';
import 'package:habit_loom/EditTaskPage.dart';
import 'package:habit_loom/RegPage.dart';
import 'package:habit_loom/HomePage.dart';
import 'package:habit_loom/DrawerPages/SettingsPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HabitLoom());
}

class HabitLoom extends StatelessWidget {
  const HabitLoom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  const AuthPage(),
        '/reg': (context) => const RegPage(),
        '/home':(context) => const HomePage(),
        '/assessment': (context) => const AssessmentPage(),
        '/tasks': (context) => const ALLTASK(),
        '/notification': (context) => const NotificationPage(),
        '/settings': (context) => const SettingsPage(),
        '/create_task' :(context) => const CreateTaskPage(),
        '/edit_task' :(context) => const EditTaskPage()
      },
    );
  }
}