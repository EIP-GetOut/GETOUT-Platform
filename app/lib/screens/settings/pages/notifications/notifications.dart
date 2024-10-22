/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();

  bool isActive = false;
  bool _firstRun = false;

  Future<bool> isFirstRun() async {
    _firstRun = await IsFirstRun.isFirstRun();
    return _firstRun;
  }

  void askForActiveNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();
    await isFirstRun();

    if (_firstRun == true) {
      Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
          isActive = true;
          sendNotif();
          saveIsActiveValueInCache();
        }
      });
    } else { // Il faut le getsession
       getIsActiveValue();
    }
  }

  void initNotif() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
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
        'Alexandre arrêtes de scroller !!!',
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

   void getIsActiveValue() async {
     bool? isActiveFromCache = false;

     SharedPreferences prefs = await SharedPreferences.getInstance();
     isActiveFromCache = prefs.getBool('notificationsIsActive');

     if (isActiveFromCache == null) {
       //todo faire la requete depuis le back (perry: peut etre pas besoin de deps du back ici)
       isActive = false;
     } else {
       isActive = isActiveFromCache;
     }
   }
}
*/

class NotificationsServices2 {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool? isNotificationPermit;

  NotificationsServices2() {
    InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings(
            '@drawable/ic_launcher_monochrome'), // mipmap/ic_launcher : take the image set of when the app is launched
        iOS: const DarwinInitializationSettings());

    flutterLocalNotificationsPlugin.initialize(initializationSettings).then((_) {
      requestPermission();
    });
  }

  Future<bool?> requestPermission() async {
    if (isNotificationPermit == null && await getNotificationCacheValue() == null) {
      isNotificationPermit = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      saveNotificationCacheValue();
    }
    return isNotificationPermit;
  }

  void showNotification() async {
    if (isNotificationPermit == false ||
        isNotificationPermit == null) {
      return;
    }
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'new_recommendation', 'New recommendation',
            icon: '@drawable/ic_launcher_monochrome',
            color: const Color(0xFFD55641),
            importance: Importance.max,
            playSound: false,
            //sound: RawResourceAndroidNotificationSound(''),
            priority: Priority.max);

    await flutterLocalNotificationsPlugin.show(
      0,
      'GetOut',
      'Arrêtes de scroller !!!',
      NotificationDetails(android: androidPlatformChannelSpecifics),
      // payload: 'Notification Payload',
    );
  }

  void saveNotificationCacheValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isNotificationPermit != null) {
      isNotificationPermit!
          ? prefs.setBool('isNotificationPermit', true)
          : prefs.setBool('isNotificationPermit', false);
    }
  }

  Future<bool?> getNotificationCacheValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isNotificationPermit = prefs.getBool('isNotificationPermit');
    return isNotificationPermit;
  }
}
