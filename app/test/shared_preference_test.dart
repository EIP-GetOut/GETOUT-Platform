/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final Future<SharedPreferences> prefsPromise =
      SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefsPromise;

  prefs.setInt('here', 32);
  if (kDebugMode) {
    print(prefs.getInt('here'));
  }
}

/*void SendTo(String path, int value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setInt(path, value);
}*/

/*  int ReceiveFrom(String path) {
    return prefs.getInt(path);
  }*/
//old vers
//  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
