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
import 'package:getout/tools/tools.dart';
import 'package:getout/widgets/page_title.dart';

class Tutorial extends StatelessWidget {
  final BuildContext formContext;
  const Tutorial({super.key, required this.formContext});

  @override
  Widget build(BuildContext context) {
    formContext
        .read<FormBloc>()
        .add(const EmitEvent(status: FormStatus.tutorial));
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const PageTitle(
              title: 'Bienvenu sur GetOut !',
              maxLines: 2,
            ),
            SizedBox(height: Tools.heightFactor(context, 0.06)),
            SvgPicture.asset('assets/images/draw/astronaut.svg',
                width: Tools.widthFactor(context, 0.7)),
            SizedBox(height: Tools.heightFactor(context, 0.06)),
            SizedBox(
              child: Center(
                child: SizedBox(
                  width: Tools.widthFactor(context, 0.84),
                  child: Column(
                    children: [
                      Text('Chaque jour, vous recevrez 5 recommandations de livres et de films.',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          )),
                      SizedBox(height: Tools.heightFactor(context, 0.02)),
                      Text('Vous pouvez indiquer si vous avez aimé ou non ces suggestions, les ajouter à votre liste, et indiquer si vous avez les avez déjà vu, cela permettra d\'affiner vos prochaines recommandations !',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
