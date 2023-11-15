import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/drawer.jpg'),
                        fit: BoxFit.cover)),
                child: ListTile(
                  textColor: Colors.white,                )),
            ListTile(
              leading: const Icon(Icons.calendar_today,
                  color: Color.fromARGB(255, 201, 231, 145)),
              title: const Text(
                'Сегодня',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.assessment_outlined,
                  color: Color.fromARGB(255, 201, 231, 145)),
              title: const Text(
                'Статистика',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/assessment');
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_stories_outlined,
                  color: Color.fromARGB(255, 201, 231, 145)),
              title: const Text(
                'Все задачи',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/tasks');
              },
            ),
            ListTile(
              leading: const Icon(Icons.alarm,
                  color: Color.fromARGB(255, 201, 231, 145)),
              title: const Text(
                'Уведомления',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/notification');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined,
                  color: Color.fromARGB(255, 201, 231, 145)),
              title: const Text(
                'Настройки',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/settings');
              },
            ),
          ],
        ));
  }
}
