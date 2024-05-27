/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_password.dart';

class EditPasswordRequestModel {
  final String oldPassword;
  final String newPassword;

  const EditPasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
  });
}

class EditPasswordResponseModel {
  final int statusCode;
  bool get isSuccessful =>
      statusCode == HttpStatus.NO_CONTENT;

  const EditPasswordResponseModel({required this.statusCode});
}
