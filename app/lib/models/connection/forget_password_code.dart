/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class ForgetPasswordCodeRequest {
  final String email;


  ForgetPasswordCodeRequest({
    required this.email,
  });
}

class ForgetPasswordCodeResponseInfo {
  static const int success = HttpStatus.OK;
  String? id;
  String? email;
  int statusCode;

  ForgetPasswordCodeResponseInfo({
    this.id,
    this.email,
    required this.statusCode
  });
}
