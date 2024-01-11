import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';


class NotificationsServices {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');


  void initNotif() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotif() async {
    print("dans send notif !");
    tz.initializeTimeZones();
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      color:  Color.fromRGBO(213, 86, 65, 1),
      colorized: true,
      icon: '@mipmap/ic_launcher',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      "GetOut",
      "Hey, tu t'ennuies ? Viens découvrir de nouvelles activités !",
      // RepeatInterval.everyDaily,
      RepeatInterval.everyMinute,
      notificationDetails
    );
  }

  void stopNotif() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
