/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/
/*
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/widgets/progress_bar.dart';
import 'package:getout/screens/form/bloc/edit_email_bloc.dart';

class SocialMediaSpentTime extends StatelessWidget {
  const SocialMediaSpentTime({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(
        builder: (context, state)
        {
          context.read<FormBloc>().add(const EmitEvent(status: FormStatus.socialMediaTime));
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 140),
                const PageIndicator(currentPage: 0, pageCount: 5),
                const SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'TEMPS PASSÉ SUR LES RÉSEAUX SOCIAUX PAR JOURS :',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '${(context.read<FormBloc>().state.time * 10).toInt()} H',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Slider(
                    thumbColor: const Color.fromRGBO(213, 86, 65, 1),
                    activeColor: const Color.fromARGB(120, 142, 1, 1),
                    secondaryActiveColor: const Color.fromRGBO(213, 86, 65, 1),
                    inactiveColor: const Color.fromARGB(120, 213, 86, 65),
                    value: context.read<FormBloc>().state.time,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    onChanged: (value) {
                      context.read<FormBloc>().add(SocialMediaTimeEvent(time: value));
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
    }
  }
*/