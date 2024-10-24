/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/tools.dart';

class EndForm extends StatelessWidget {
  final BuildContext formContext;

  const EndForm({required this.formContext, super.key});

  @override
  Widget build(BuildContext context) {
    formContext
        .read<FormBloc>()
        .add(const EmitEvent(status: FormStatus.endForm));
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: Tools.heightFactor(context, 0.07)),
            const PageTitle(
              title: 'Vos réponses ont bien été enregistrées',
              description:
                  'Ce formulaire nous permet de vous proposer une expérience personnalisée.',
              maxLines: 2,
            ),
            SizedBox(height: Tools.heightFactor(context, 0.05)),
            SvgPicture.asset('assets/images/draw/form_complete.svg',
                width: Tools.widthFactor(context, 1)),
          ],
        ),
      ),
    );
  }
}
