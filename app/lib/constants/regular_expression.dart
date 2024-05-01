/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

class RegularExpression {
  const RegularExpression();

  static const String email = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
  static const String password = r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$';
}