/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/widgets/four_point.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';
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
          SizedBox(height: Tools.heightFactor(context, 0.10)),
          const PageIndicator(currentPage: 1, pageCount: 3),
          SizedBox(height: Tools.heightFactor(context, 0.05)),
          Center(
            child: SizedBox(
              width: Tools.widthFactor(context, 0.75),
              child: AutoSizeText(
                'GENRES CINÉMATOGRAPHIQUES :',
                maxLines: 2,
                minFontSize: 18.0,
                maxFontSize: 24.0,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
                wrapWords: true,
              ),
            ),
            /*Text(
              'GENRES CINÉMATOGRAPHIQUES :',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),*/
          ),
          SizedBox(height: Tools.heightFactor(context, 0.03)),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  for (var checkbox in context.read<FormBloc>().state.filmGenres.entries)
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Text(checkbox.key,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                          ),
                          value: checkbox.value,
                          onChanged: (value) {
                            context.read<FormBloc>().add(FilmGenresEvent(key: checkbox.key));
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
                        SizedBox(height: Tools.heightFactor(context, 0.012)),
                      ],
                    ),
                ]),
          )
        ],
      );
    });
  }
}
