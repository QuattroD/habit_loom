import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final androidInitialize = new AndroidInitializationSettings('');

void initialNotification () async {
  InitializationSettings initializationSettings = InitializationSettings(android: androidInitialize);
  flutterLocalNotificationsPlugin.initialize(initializationSettings); 
}

void sendNotification () async {
  AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
    'channelId', 
    'channelName',
    importance: Importance.max,
    priority: Priority.max);

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(23, 'test', 'test2', notificationDetails);
}
}