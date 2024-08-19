/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:url_launcher/url_launcher.dart';

Future<void> launchWebView(String? link) async {
  if (link != '') {
    final Uri url = Uri.parse(link ?? '');
    await launchUrl(url, mode: LaunchMode.inAppWebView);
  }
}