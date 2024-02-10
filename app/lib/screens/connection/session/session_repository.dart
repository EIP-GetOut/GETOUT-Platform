/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/screens/connection/session/session_event.dart';
import 'package:getout/screens/connection/session/session_service.dart';

class SessionRepository {
  const SessionRepository({
    required this.service,
  });
  final SessionService service;

  Future<SessionStatusResponse> getSession() async =>
      service.getSession();
}
