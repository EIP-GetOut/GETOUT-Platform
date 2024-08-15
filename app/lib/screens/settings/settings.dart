/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/settings/pages/disconnect/disconnect.dart';
import 'package:getout/screens/settings/pages/delete_account/delete_account.dart';

import 'package:getout/screens/form/pages/form.dart';
import 'package:getout/screens/settings/pages/edit_email/edit_email.dart';
import 'package:getout/screens/settings/pages/edit_password/edit_password.dart';
import 'package:getout/screens/settings/pages/history/history_provider.dart';
import 'package:getout/screens/settings/pages/notifications/notifications_page.dart';
import 'package:getout/screens/settings/widget/account_info.dart';
import 'package:getout/screens/settings/widget/setting_row.dart';
import 'package:getout/screens/settings/widget/title.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/app_l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        PageTitle(title: appL10n(context)!.settings, description: appL10n(context)!.settings_label),
            const SizedBox(height: 30),
            const AccountInfo(),
            TitleRow(value: appL10n(context)!.account),
            SettingRow(
                page: const EditPasswordPage(),
                iconData: Icons.shield_outlined,
                value: appL10n(context)!.edit_password),
            SettingRow(
                page: const EditEmailPage(),
                iconData: Icons.mail_outlined,
                value: appL10n(context)!.edit_email),

            const DisconnectPage(),
            const DeleteAccountPage(),
            TitleRow(value: appL10n(context)!.appearance),
            /*SettingRow(
                page: const SizedBox(),
                iconData: Icons.public_outlined,
                value: appL10n(context)!.select_language),*/
            TitleRow(value: appL10n(context)!.preference),
            SettingRow(page: const HistoryProvider(), iconData: Icons.history_outlined, value: appL10n(context)!.history),
            SettingRow(page: const Forms(), iconData : Icons.settings_outlined, value: appL10n(context)!.select_preferences),
            SettingRow(page: const NotificationsPage(), iconData: Icons.notifications_outlined, value: appL10n(context)!.notifications),
            //TitleRow(value: appL10n(context)!.more),
            /*todo SettingRow(
                page: const SizedBox(),
                iconData: Icons.help_outline,
                value: appL10n(context)!.support),*/
          ],
        ),
      ),
    );
  }
}
