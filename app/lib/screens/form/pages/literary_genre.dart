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
import 'package:getout/tools/screen_size_factor.dart';

class LiteraryGenres extends StatelessWidget {
  const LiteraryGenres({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.literaryGenres));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: heightFactor(context, 0.10)),
          const PageIndicator(currentPage: 2, pageCount: 5),
          SizedBox(height: heightFactor(context, 0.05)),
          Center(
            child: Text(
              'GENRES LITTÉRAIRES :',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: heightFactor(context, 0.03)),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  for (var checkbox in context.read<FormBloc>().state.literaryGenres.entries)
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Text(checkbox.key,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                          ),
                          value: checkbox.value,
                          onChanged: (value) {
                            context.read<FormBloc>().add(LiteraryGenresEvent(key: checkbox.key));
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
                        SizedBox(height: heightFactor(context, 0.012)),
                      ],
                    ),
                ]),
          )
        ],
      );
    });
  }
}
