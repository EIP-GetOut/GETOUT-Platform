/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:getout/screens/connection/get_session/bloc/get_session_event.dart';
import 'package:getout/screens/connection/get_session/bloc/get_session_service.dart';

class UserData {
   UserData({
    this.isSigned = false,
  });

  // set isSigned(bool value) {
  //   isSigned = value;
  // }

  Future<void> setIsSigned() async {
    final session = await GetSessionService().getSession(const GetSessionRequest());
    // print("set is signed = ");
    // print(session.id);
    // if (session.id != null) {
    //   isSigned = true;
    // }
  }

  bool isSigned;
}
