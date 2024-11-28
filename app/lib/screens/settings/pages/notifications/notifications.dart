/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

import 'package:getout/global.dart' as globals;

class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool? isNotificationPermit;
  bool isNotificationEnable = true;

  NotificationsServices() {
    InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings(
            '@drawable/ic_launcher_monochrome'), // mipmap/ic_launcher : take the image set of when the app is launched
        iOS: const DarwinInitializationSettings());

    tz_data.initializeTimeZones();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> initNotification() async {
    final bool? enableNotification = await getEnableNotificationCache();
    isNotificationPermit = await getPermitNotificationCache();

    if (isNotificationPermit == null) {
      requestPermission();
    }
    if (enableNotification != null) {
      isNotificationEnable = enableNotification;
    }
    if (isNotificationPermit == false) {
      isNotificationEnable = false;
      return;
    }
    await scheduleNotification();
  }

  Future<bool?> requestPermission() async {
    PermissionStatus permission = await Permission.notification.request();
    if (permission == PermissionStatus.granted) {
      isNotificationPermit = true;
    } else if (permission == PermissionStatus.denied) {
      isNotificationPermit = false;
    } else {
      // permission can be "permanentlyDenied"
      return null;
    }
    isNotificationEnable = isNotificationPermit!;
    saveEnableNotification();
    savePermitNotification();
    return isNotificationPermit;
  }

  Future<void> scheduleNotification() async {
    final int? timeBeforeNotification =
        globals.session?['secondsBeforeNextMovieRecommendation'];

    if (timeBeforeNotification == null ||
        isNotificationPermit == null ||
        isNotificationPermit == false ||
        isNotificationEnable == false) {
      return;
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'GetOut',
      'Nouvelles recommandations disponibles !',
      tz.TZDateTime.now(tz.local)
          .add(Duration(seconds: timeBeforeNotification)),
      NotificationDetails(
        android: AndroidNotificationDetails(
            'new_recommendation', 'New recommendation',
            icon: '@drawable/ic_launcher_monochrome',
            color: const Color(0xFFD55641),
            importance: Importance.max,
            playSound: false,
            //sound: RawResourceAndroidNotificationSound(''),
            priority: Priority.max),
        iOS: const DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,

      // To show notification even when the app is closed
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // Show notification at the same time everyday
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelScheduledNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> savePermitNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isNotificationPermit != null) {
      isNotificationPermit!
          ? prefs.setBool('isNotificationPermit', true)
          : prefs.setBool('isNotificationPermit', false);
    }
  }

  Future<bool?> getPermitNotificationCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isNotificationPermit = prefs.getBool('isNotificationPermit');
    return isNotificationPermit;
  }

  Future<void> saveEnableNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isNotificationEnable
        ? prefs.setBool('isNotificationEnable', true)
        : prefs.setBool('isNotificationEnable', false);
  }

  Future<bool?> getEnableNotificationCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isNotificationEnable');
  }
}
