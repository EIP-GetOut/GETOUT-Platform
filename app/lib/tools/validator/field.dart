/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

String? mandatoryValidator(String? field) {
  if (field == null || field == '') {
    return 'Ce champs ne peut pas etre vide';
  }
  return null;
}