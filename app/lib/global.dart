library my_app.globals;

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:getout/screens/settings/pages/notifications/notifications.dart';

List<bool> boxMovieValue = [false, false, false, false, false];
List<bool> boxBookValue = [false, false, false, false, false];
List<bool> boxInterestValue = [false, false, false, false, false];

String? globalEmail;

NotificationsServices notificationsServices = NotificationsServices();

// ignore: prefer_single_quotes
PersistCookieJar cookieJar = PersistCookieJar(ignoreExpires: true, storage: FileStorage("/data/user/0/com.example.GetOut/app_flutter/.cookies/"));
Dio dio = Dio();
