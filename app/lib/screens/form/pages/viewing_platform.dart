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

class ViewingPlatform extends StatelessWidget {
  const ViewingPlatform({super.key});

  @override
  Widget build(BuildContext context)
  {
    List<String> imagesList = [
      'assets/images/logo/netflix.png',
      'assets/images/logo/prime_video.png',
      'assets/images/logo/disney+.png',
      'assets/images/logo/cinema.png',
      'assets/images/logo/DVD.png'
    ];
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      final Map<String, bool> viewingPlatform =
          context.read<FormBloc>().state.viewingPlatform;
      // When I create this variable,
      // only god and I knew how it worked. Now, only god knows it
      final Map<String, String> checkboxImages = Map.fromEntries(
          viewingPlatform.entries.map((entry) => MapEntry(
              entry.key,
              imagesList[viewingPlatform.keys.toList().indexOf(entry.key)])));

      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.viewingPlatform));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: heightFactor(context, 0.10)),
          const PageIndicator(currentPage: 4, pageCount: 5),
          SizedBox(height: heightFactor(context, 0.05)),
          Center(
            child: Text(
              'SUPPORT DE VISIONNAGE :',
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
                  for (var checkbox
                      in context.read<FormBloc>().state.viewingPlatform.entries)
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Row(
                            children: [
                              SizedBox(width: widthFactor(context, 0.12)),
                              Image.asset(checkboxImages[checkbox.key]!,
                                  width: 40, height: 40),
                              SizedBox(width: widthFactor(context, 0.02)),
                              Text(checkbox.key,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          value: checkbox.value,
                          onChanged: (value) {
                            context
                                .read<FormBloc>()
                                .add(ViewingPlatformEvent(key: checkbox.key));
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
