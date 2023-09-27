/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:http_status_code/http_status_code.dart';

class CreateAccountRequest {
    final String email;
    final String password;
    final String firstName;
    final String lastName;
    final String bornDate;

  CreateAccountRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.bornDate,
  });
}

class AccountResponseInfo
{
  static const int success = StatusCode.CREATED;
  String? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? bornDate;
  int statusCode;

  AccountResponseInfo({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.bornDate,
    required this.statusCode
  });
}
