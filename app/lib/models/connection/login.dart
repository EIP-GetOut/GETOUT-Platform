/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class LoginRequest {
    final String email;
    final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

class LoginResponseInfo
{
  static const int success = HttpStatus.OK;
  String? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? bornDate;
  int statusCode;

  LoginResponseInfo({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.bornDate,
    required this.statusCode
  });
}
