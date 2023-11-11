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
    tz.initializeTimeZones();
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      icon: '@mipmap/ic_launcher',
      color:  Color.fromRGBO(213, 86, 65, 1),
      colorized: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'GetOut',
      "Hey, tu t'ennuies ? Viens découvrir de nouvelles activités !",
      RepeatInterval.everyMinute, // pour les test sinon c'est everyDaily
      notificationDetails
    );
  }

  void stopNotif() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
