/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class OauthRequest {
    final String email;
    final String id;

    OauthRequest({
    required this.email,
    required this.id,
  });
}

class OauthResponseInfo
{
  static const int success = HttpStatus.OK;
  int statusCode;

  OauthResponseInfo({
    required this.statusCode
  });
}
