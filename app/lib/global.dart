/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:getout/bloc/session/session_service.dart';
import 'package:getout/screens/settings/pages/notifications/notifications.dart';

/*Todo:
   - create anything not global (bloc/class)
   - handle real type
   - add session.isNull method
   */

//String? globalEmail;

NotificationsServices notificationsServices = NotificationsServices();

String? cookiePath;
bool isCookieSet = false;

// Using dynamic type because data can be a string, a list, a map, etc
Map<String, dynamic>? session;

SessionService sessionManager = SessionService();