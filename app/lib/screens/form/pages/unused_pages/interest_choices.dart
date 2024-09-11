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

class InterestChoices extends StatelessWidget {
  const InterestChoices({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.interestChoices));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 140),
          const PageIndicator(currentPage: 1, pageCount: 5),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'CENTRE D\'INTERÊT :',
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
                  for (var checkbox in context.read<FormBloc>().state.interest.entries)
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Text(checkbox.key,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                          ),
                          value: checkbox.value,
                          onChanged: (value) {
                            context.read<FormBloc>().add(InterestChoicesEvent(key: checkbox.key));
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
*/