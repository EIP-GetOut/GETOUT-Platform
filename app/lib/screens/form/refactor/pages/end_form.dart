/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/refactor/bloc/form_bloc.dart';

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
            const SizedBox(height: 140),
            Image.asset('assets/images/Logo_Full_GetOut.png', scale: 0.85),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Image.asset('assets/images/Icon_Phone_Check.png', scale: 1.6),
                Image.asset('assets/images/Draw_Woman.png', scale: 2.5),
              ],
            ),
            const SizedBox(height: 20),
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
