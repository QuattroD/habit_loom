import 'package:flutter/material.dart';
import 'package:habit_loom/Drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //синхронизация с firebase timeMorning timeDay timeEvening
  TimeOfDay timeMorning = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay timeDay = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay timeEvening = const TimeOfDay(hour: 00, minute: 00);
  bool _switchValueVolume = false;
  bool _switchValueRest = false;

  @override
  Widget build(BuildContext context) {
    final hoursMorning = timeMorning.hour.toString().padLeft(2, '0');
    final minutesMorning = timeMorning.minute.toString().padLeft(2, '0');

    final hoursDay = timeDay.hour.toString().padLeft(2, '0');
    final minutesDay = timeDay.minute.toString().padLeft(2, '0');

    final hoursEvening = timeEvening.hour.toString().padLeft(2, '0');
    final minutesEvening = timeEvening.minute.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 76, 142, 93),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: const Text(
          'Настройки',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const DrawerMenu(),
      body: ListView(
        children: [
          const ListTile(
            leading: Text('ВРЕМЯ СУТОК',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(
              Icons.sunny,
              color: Colors.orange,
            ),
            title: const Text('Утро',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(
              '$hoursMorning:$minutesMorning',
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () async {
              TimeOfDay? newTime = await showTimePicker(
                  context: context, initialTime: timeMorning);
              if (newTime == null) return;
              setState(() => timeMorning = newTime);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.cloud,
              color: Colors.blue,
            ),
            title: const Text('День',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(
              '$hoursDay:$minutesDay',
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () async {
              TimeOfDay? newTime =
                  await showTimePicker(context: context, initialTime: timeDay);
              if (newTime == null) return;
              setState(() => timeDay = newTime);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.nightlight,
              color: Colors.yellow,
            ),
            title: const Text('Вечер',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(
              '$hoursEvening:$minutesEvening',
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () async {
              TimeOfDay? newTime = await showTimePicker(
                  context: context, initialTime: timeEvening);
              if (newTime == null) return;
              setState(() => timeEvening = newTime);
            },
          ),
          const ListTile(
            leading: Text('ОБЩИЕ',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(
              Icons.volume_up,
              color: Colors.blue,
            ),
            title: const Text('Звук',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: Switch(
                inactiveTrackColor: Colors.grey,
                activeTrackColor: Colors.green,
                activeColor: Colors.white,
                value: _switchValueRest,
                onChanged: (value) {
                  setState(() {
                    _switchValueRest = value;
                  });
                }),
            onTap: () async {},
          ),
          ListTile(
            leading: const Icon(
              Icons.beach_access,
              color: Colors.yellow,
            ),
            title: const Text('Режим отдыха',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text(
              'Приостановить все задачи без потери статистики',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
                inactiveTrackColor: Colors.grey,
                activeTrackColor: Colors.green,
                activeColor: Colors.white,
                value: _switchValueVolume,
                onChanged: (value) {
                  setState(() {
                    _switchValueVolume = value;
                  });
                }),
            onTap: () async {},
          ),
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06)),
          Container(
              height: MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)
              ),
              child: InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/');
                },
                child: const Center(
                child: Text(
                  'ВЫЙТИ',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25),
                ),
              ),
              )
            ),
        ],
      ),
    );
  }
}
