/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/settings/pages/edit_email/edit_mail.dart';
import 'package:getout/screens/settings/pages/edit_password/edit_password.dart';
import 'package:getout/screens/settings/widget/account_info.dart';
import 'package:getout/screens/settings/widget/setting_row.dart';
import 'package:getout/screens/settings/widget/title.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isActivated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('PARAMÈTRES'),
        leading: const BackButton(),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
//            Divider(height: 20, thickness: 1),
            AccountInfo(),
            TitleRow(value: 'compte'),
            SettingRow(page: EditPasswordPage(), iconData: Icons.shield_outlined, value: 'Changer de mot de passe'),
            SettingRow(page: EditMailPage(), iconData: Icons.mail_outlined, value: 'Changer d\'adresse email'),
            SettingRow(page: SizedBox(), iconData: Icons.exit_to_app_outlined, value: 'Se déconnecter', important: Important.warning),
            SettingRow(page: SizedBox(), iconData: Icons.delete_outlined, value: 'Supprimer son compte', important: Important.important),
            TitleRow(value: 'apparence'),
            SettingRow(page: SizedBox(), iconData: Icons.public_outlined, value: 'Choisir la langue'),
            TitleRow(value: 'preference'),
            SettingRow(page: SizedBox(), iconData: Icons.settings_outlined, value: 'Changer les preferences'),
            SettingRow(page: SizedBox(), iconData: Icons.notifications_outlined, value: 'Notifications'),
            TitleRow(value: 'autre'),
            SettingRow(page: SizedBox(), iconData: Icons.help_outline, value: 'Support'),
          ],
        ),
      ),
    );
  }
}

GestureDetector buildParameters(
    BuildContext context, String title, StatefulWidget page) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.lock, color: Colors.grey),
            Text(title,
                style: TextStyle(fontSize: 20, color: Colors.grey[800])),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
          ],
        )),
  );
}
