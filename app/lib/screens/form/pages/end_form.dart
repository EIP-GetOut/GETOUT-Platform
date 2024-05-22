/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/tools/tools.dart';

class EndForm extends StatelessWidget {
  const EndForm({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.endForm));
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            SizedBox(height: Tools.heightFactor(context, 0.17)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Image.asset('assets/images/icon/phone_check.png', scale: 2),
                SizedBox(width: Tools.widthFactor(context, 0.06)),
                Image.asset('assets/images/draw/welcome_image.png', scale: 3.3),
              ],
            ),
            SizedBox(height: Tools.heightFactor(context, 0.035)),
            const Center(
              child: Text(
                'VOS RÉPONSES ONT BIEN ÉTÉ ENREGISTRÉES !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    },
    );
  }
}
