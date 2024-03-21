/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:getout/constants/regular_expression.dart';

String? newPasswordValidator(String? password) {
  RegExp regex = RegExp(RegularExpression.password);

  if (password == null || !regex.hasMatch(password)) {
    return 'Le mot de passe dois contenir au minimum 8 caractères, dont une majuscule, une minuscule et un chiffre';
  }
  return null;
}

String? confirmPasswordValidator(String? newPassword, String? confirmPassword) {
  String? result = newPasswordValidator(confirmPassword);

  if (result != null) {
    return result;
  }
  return (newPassword != confirmPassword)
      ? 'Les nouveaux mots de passe saisies ne correspondent pas.'
      : null;
}
