import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:is_first_run/is_first_run.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  bool isActive = false;
  bool firstRun = false;

  Future<bool> isFirstRun() async {
    firstRun = await IsFirstRun.isFirstRun();
    return firstRun;
  }

  void askForActiveNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();
    await isFirstRun();

    if (firstRun == true) {
      Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
          isActive = true;
          sendNotif();
          saveIsActiveValueInCache();
        }
      });
    }
    // Il faut le getsession
    //else {
    //   getIsActiveValue();
    // }
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
    isActive = true;
    saveIsActiveValueInCache();
  }

  void stopNotif() async {
    flutterLocalNotificationsPlugin.cancelAll();
    isActive = false;
    saveIsActiveValueInCache();
  }

   void saveIsActiveValueInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isActive ? prefs.setBool('notificationsIsActive', true) : prefs.setBool('notificationsIsActive', false);
  }

// Il faut le getsession pour cette partie

  // void getIsActiveValue() async {
  //   bool? isActiveFromCache = false;

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isActiveFromCache = prefs.getBool('notificationsIsActive');


  //   if (isActiveFromCache == null) {
  //     // faire la requete depuis le back
  //   } else {
  //     isActive = isActiveFromCache;
  //   }
  // }
}
