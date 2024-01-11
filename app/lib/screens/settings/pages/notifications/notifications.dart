import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:is_first_run/is_first_run.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:getout/global.dart' as globals;

class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  bool isActive = false;
  bool firstRun = false;

  void isFirstRun() async {
    firstRun = await IsFirstRun.isFirstRun();
  }

  void askForActiveNotifications() {
    WidgetsFlutterBinding.ensureInitialized();
    globals.notificationsServices.isFirstRun();

    if (globals.notificationsServices.firstRun == true) {
      Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
          globals.notificationsServices.isActive = true;
          globals.notificationsServices.sendNotif();
        }
      });
    }
  }

  void initNotif() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotif() async {
    tz.initializeTimeZones();
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      color: Color.fromRGBO(213, 86, 65, 1),
      colorized: true,
      icon: '@mipmap/ic_launcher',
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'GetOut',
        "Hey, tu t'ennuies ? Viens découvrir de nouvelles activités !",
        // RepeatInterval.daily,
        // pour la demo il faut utiliser :
        RepeatInterval.everyMinute,
        notificationDetails);
  }

  void stopNotif() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
