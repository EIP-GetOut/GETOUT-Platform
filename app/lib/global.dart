library my_app.globals;

import 'package:getout/screens/settings/pages/notifications/notifications.dart';

List<bool> boxMovieValue = [false, false, false, false, false];
List<bool> boxBookValue = [false, false, false, false, false];
List<bool> boxInterestValue = [false, false, false, false, false];

String? globalEmail;

NotificationsServices notificationsServices = NotificationsServices();