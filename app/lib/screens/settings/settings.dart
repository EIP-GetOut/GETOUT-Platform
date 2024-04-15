/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/settings/pages/edit_email/edit_mail.dart';
import 'package:getout/screens/settings/pages/edit_password/edit_password.dart';
import 'package:getout/screens/settings/pages/notifications/notifications_page.dart';
import 'package:getout/screens/settings/widget/account_info.dart';
import 'package:getout/screens/settings/widget/setting_row.dart';
import 'package:getout/screens/settings/widget/title.dart';
import 'package:getout/tools/app_l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('PARAMÈTRES'),
        leading: const BackButton(),
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
//            Divider(height: 20, thickness: 1),
            const AccountInfo(),
            TitleRow(value: appL10n(context)!.account),
            SettingRow(page: const EditPasswordPage(), iconData: Icons.shield_outlined, value: appL10n(context)!.edit_password),
            SettingRow(page: const EditMailPage(), iconData: Icons.mail_outlined, value: appL10n(context)!.edit_email),
            SettingRow(page: const SizedBox(), iconData: Icons.exit_to_app_outlined, value: appL10n(context)!.disconnect, important: Important.warning),
            SettingRow(page: const SizedBox(), iconData: Icons.delete_outlined, value: appL10n(context)!.delete_account, important: Important.important),
            const TitleRow(value: 'apparence'),
            SettingRow(page: const SizedBox(), iconData: Icons.public_outlined, value: appL10n(context)!.select_language),
            const TitleRow(value: 'preference'),
            SettingRow(page: const SizedBox(), iconData: Icons.settings_outlined, value: appL10n(context)!.select_preferences),
            SettingRow(page: const NotificationsPage(), iconData: Icons.notifications_outlined, value: appL10n(context)!.notifications),
            const TitleRow(value: 'autre'),
            const SettingRow(page: SizedBox(), iconData: Icons.help_outline, value: 'Support'),
          ],
        ),
      ),
    );
  }
}
