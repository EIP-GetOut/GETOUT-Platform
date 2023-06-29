/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:http_status_code/http_status_code.dart';

class SettingsEditPasswordRequest {
  final String email;
  final String password;
  final String newPassword;


  SettingsEditPasswordRequest({
    required this.email,
    required this.password,
    required this.newPassword,
  });
}

class SettingsEditPasswordResponseInfo
{
  static const int success = StatusCode.OK;
  String? id;
  String? email;
  String? password;
  int statusCode;

  SettingsEditPasswordResponseInfo({
    this.id,
    this.password,
    this.email,
    required this.statusCode
  });
}
