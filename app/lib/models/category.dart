/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

class Category {
  String title;
  bool? isSwitched;

  Category({
    required this.title,
    this.isSwitched = false,
  });
}
