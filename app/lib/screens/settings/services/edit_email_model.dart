/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_email.dart';

class EditEmailRequestModel {
  final String email;

  const EditEmailRequestModel({
    required this.email,
  });
}

class EditEmailResponseModel {
  final int statusCode;
  bool get isSuccessful =>
      statusCode == HttpStatus.NO_CONTENT;

  const EditEmailResponseModel({required this.statusCode});
}

class EmailVerificationRequestModel {
  const EmailVerificationRequestModel({required this.code});

  final String code;
}

class EmailVerificationResponseModel {
  const EmailVerificationResponseModel({required this.statusCode});

  bool get isSuccessful =>
      statusCode == HttpStatus.NO_CONTENT;
  final int statusCode;
}
