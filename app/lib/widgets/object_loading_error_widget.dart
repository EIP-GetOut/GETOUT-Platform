/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:boxicons/boxicons.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/transition_page.dart';

//todo responsiveclass ObjectLoadingErrorWidget extends StatelessWidget {
 class ObjectLoadingErrorWidget extends StatelessWidget {
  final String object;

  const ObjectLoadingErrorWidget({super.key, required this.object});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Boxicons.bx_error, size: 40, color: Colors.red),
          const SizedBox(width: 10), // Add some space between the icon and the text
          TransitionPage(
                    title: appL10n(context)!.error_unknown_short,
                    description: appL10n(context)!.error_unknown_description,
                    image: 'assets/images/draw/error.svg',
                    buttonText: appL10n(context)!.error_ok,
                    nextPage: () => {
                          Navigator.pop(context),
                        }),
        ],
      ),
    );
  }
}
