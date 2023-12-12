/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class ForgetPasswordChangeRequest {
  final String email;
  final String code;
  final String password;

  ForgetPasswordChangeRequest({
    required this.email,
    required this.code,
    required this.password,
  });
}

class ForgetPasswordChangeResponseInfo
{
  static const int success = HttpStatus.OK;
  String? id;
  String? email;
  String? password;
  int statusCode;

  ForgetPasswordChangeResponseInfo({
    this.id,
    this.password,
    this.email,
    required this.statusCode
  });
}
