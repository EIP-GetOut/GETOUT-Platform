/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/widgets/four_point.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';

class FilmGenres extends StatelessWidget {
  const FilmGenres({super.key});

  @override
  Widget build(BuildContext context)
  {
    List<String> checkboxText = [
      'Action',
      'Thriller',
      'Western',
      'Horreur',
      'Comédie'
    ];

    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.filmGenres));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 140),
          const PageIndicator(currentPage: 3, pageCount: 5),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'GENRES CINÉMATOGRAPHIQUES :',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  for (int i = 0; i < checkboxText.length; i++)
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Text(checkboxText[i],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                          ),
                          value: context.read<FormBloc>().state.filmGenres[i],
                          onChanged: (value) {
                            context.read<FormBloc>().add(FilmGenresEvent(index: i));
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          tileColor: Colors.transparent,
                          checkColor: Colors.transparent,
                          activeColor: Theme.of(context).primaryColor,
                          shape: const Border(
                            bottom: BorderSide(color: Colors.black, width: 2.0),
                            left: BorderSide(color: Colors.black, width: 2.0),
                            right: BorderSide(color: Colors.black, width: 2.0),
                            top: BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                ]),
          )
        ],
      );
    });
  }
}
