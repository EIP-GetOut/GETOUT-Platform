/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

String formatSpendTime(String text, int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  if (text != '') {
    return '$text ${parts[0].padLeft(2, '0')}h${parts[1].padLeft(2, '0')}';
  } else {
    return '${parts[0].padLeft(2, '0')}h${parts[1].padLeft(2, '0')}';
  }
}
