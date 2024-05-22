/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

extension StringExtension on String {
  String get toSentenceCase => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String get toCapitalizedCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toSentenceCase).join(' ');
}