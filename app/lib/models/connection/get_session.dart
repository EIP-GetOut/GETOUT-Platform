/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class SessionResponseInfo {
  static const int success = HttpStatus.OK;
  String? cookie;
  int statusCode;

  SessionResponseInfo({
    this.cookie,
    required this.statusCode
  });
}