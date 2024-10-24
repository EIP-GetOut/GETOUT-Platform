/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/bloc/session/session_service.dart';

/*Todo:
   - create anything not global (bloc/class)
   - handle real type
   - add session.isNull method
   */

//NotificationsServices notificationsServices = NotificationsServices();

String? cookiePath;
bool isCookieSet = false;

// Using dynamic type because data can be a string, a list, a map, etc
Map<String, dynamic>? session;

SessionService sessionManager = SessionService();

final BaseOptions dioOptions = BaseOptions(
  connectTimeout: Duration(minutes: 1),
  receiveTimeout: Duration(minutes: 1),
  sendTimeout: Duration(minutes: 1),
  headers: ({'Content-Type': 'application/json'})
);