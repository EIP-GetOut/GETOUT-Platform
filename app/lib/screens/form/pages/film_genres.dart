/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/widgets/checkbox.dart';
import 'package:getout/screens/form/widgets/progress_bar.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/tools.dart';

class FilmGenres extends StatelessWidget {
  const FilmGenres({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.filmGenres));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: Tools.heightFactor(context, 0.03)),
          const PageTitle(
            title: 'Genres audiovisuel',
            description: 'Ce formulaire nous permet de vous proposer une expérience personnalisée.',
          ),
          SizedBox(height: Tools.heightFactor(context, 0.06)),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const ProgressBar(total: 3, current: 2)),
          SizedBox(height: Tools.heightFactor(context, 0.05)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 65.0),
              child: FormCheckbox(
                checkboxList: context.read<FormBloc>().state.filmGenres,
                checkboxImages: null,
                event: const FilmGenresEvent(key: ''),
              )
            ),
          )
        ],
      );
    });
  }
}
