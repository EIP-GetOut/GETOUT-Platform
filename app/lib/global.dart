library my_app.globals;

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import 'package:getout/bloc/session/session_service.dart';
import 'package:getout/screens/settings/pages/notifications/notifications.dart';

List<bool> boxMovieValue = [false, false, false, false, false];
List<bool> boxBookValue = [false, false, false, false, false];
List<bool> boxInterestValue = [false, false, false, false, false];

String? globalEmail;

NotificationsServices notificationsServices = NotificationsServices();

PersistCookieJar? cookieJar;
Dio? dio;

String? session;

SessionService sessionManager = SessionService();