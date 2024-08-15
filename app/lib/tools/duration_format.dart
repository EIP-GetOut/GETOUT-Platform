/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

String durationFormat(final String text, final int minutes) {
  final Duration d = Duration(minutes: minutes);
  final List<String> parts = d.toString().split(':');

  // if (minutes <= 0) {
  //   return '';
  // }

  return '$text ${parts[0].padLeft(2, '0')}h${parts[1].padLeft(2, '0')}';
}

String durationFormatSeconds(final String text, final int seconds) {
  final Duration d = Duration(seconds: seconds);
  final String hours = d.inHours.toString().padLeft(2, '0');
  final String minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
  final String secs = (d.inSeconds % 60).toString().padLeft(2, '0');

  if (seconds == 0) {
    return 'Nouvelles recommandations disponibles !';
  }
  return '$text ${hours}h${minutes}m${secs}s';
}
