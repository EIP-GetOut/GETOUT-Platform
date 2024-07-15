/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:getout/screens/form/pages/form.dart';

import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/tools.dart';

import 'package:getout/tools/app_l10n.dart';

class EmailVerifiedSuccessPage extends StatelessWidget {
  const EmailVerifiedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    // {
    //   context.read<FormBloc>().add(const EmitEvent(status: FormStatus.endForm));
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: Tools.heightFactor(context, 0.07)),
            PageTitle(
              title: appL10n(context)!.email_verification_success,
              description: appL10n(context)!.email_verification_success_desc,
              maxLines: 2,
            ),
            const SizedBox(height: 50),
            SvgPicture.asset('assets/images/draw/email_verified_complete.svg',
                width: Tools.widthFactor(context, 1)),
            const SizedBox(height: 110),
            DefaultButton(
                title: appL10n(context)!.email_verification_success_button,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Forms();
                  }));
                }),
          ],
        ),
      ),
    );
    // },
    // );
  // },
  //   );
  }
}
