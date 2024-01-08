/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/widgets/four_point.dart';
import 'package:getout/screens/form/refactor/bloc/form_bloc.dart';

class ViewingPlatform extends StatelessWidget {
  const ViewingPlatform({super.key});

  @override
  Widget build(BuildContext context)
  {
    List<String> checkboxText = [
      'Netflix',
      'Prime Video',
      'Disney +',
      'Cinema',
      'DVD'
    ];
    List<String> checkboxImagePath = [
      'assets/images/Logo_Netflix.png',
      'assets/images/Logo_Prime_video.png',
      'assets/images/Logo_Disney+.png',
      'assets/images/Logo_Cinema.png',
      'assets/images/Logo_DVD.png'
    ];

    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      context.read<FormBloc>().add(EmitEvent(status: FormStatus.viewingPlatform));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 140),
          const PageIndicator(currentPage: 4, pageCount: 5),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'SUPPORT DE VISIONNAGE :',
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
                          title: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 50.0),
                              Image.asset(checkboxImagePath[i], width: 40, height: 40),
                              const SizedBox(width: 8.0),
                              Text(checkboxText[i], style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          value: context.read<FormBloc>().state.viewingPlatform[i],
                          onChanged: (value) {
                            context.read<FormBloc>().add(ViewingPlatformEvent(index: i));
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          tileColor: Colors.transparent,
                          shape: const Border(
                            bottom: BorderSide(color: Colors.black, width: 2.0),
                            left: BorderSide(color: Colors.black, width: 2.0),
                            right: BorderSide(color: Colors.black, width: 2.0),
                            top: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          checkColor: Colors.transparent,
                          activeColor: Theme.of(context).primaryColor,
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
