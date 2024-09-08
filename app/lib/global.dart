library my_app.globals;

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