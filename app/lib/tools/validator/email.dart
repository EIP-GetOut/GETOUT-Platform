/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:getout/constants/regular_expression.dart';

String? emailValidator(String? email) {
  RegExp regex = RegExp(RegularExpression.email);

  if (email == null || !regex.hasMatch(email)) {
    return 'Entrer un email valide';
  }
  return null;
}

String? confirmEmailValidator(String? newEmail, String? confirmEmail) {
  String? result = emailValidator(confirmEmail);

  if (result != null) {
    return result;
  }
  return (newEmail != confirmEmail)
      ? 'Les nouvelles adresses email saisies ne correspondent pas.'
      : null;
}
