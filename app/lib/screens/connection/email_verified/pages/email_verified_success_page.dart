/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/tools.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';

class EmailVerifiedSuccessPage extends StatelessWidget {
  const EmailVerifiedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: Tools.heightFactor(context, 0.07)),
                PageTitle(
                  title: appL10n(context)!.email_verification_success,
                  description:
                      appL10n(context)!.email_verification_success_desc,
                  maxLines: 2,
                ),
                const SizedBox(height: 50),
                SvgPicture.asset(
                    'assets/images/draw/email_verified_complete.svg',
                    width: Tools.widthFactor(context, 1)),
                const SizedBox(height: 110),
                DefaultButton(
                    title: appL10n(context)!.email_verification_success_button,
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<SessionBloc>().add(const SessionRequest());
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}