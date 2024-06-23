/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/widgets/checkbox.dart';
import 'package:getout/screens/form/widgets/four_point.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/tools/tools.dart';

class ViewingPlatform extends StatelessWidget {
  const ViewingPlatform({super.key});

  static const List<String> _imagesList = [
    'assets/images/logo/cinema.png',
    'assets/images/logo/DVD.png',
    'assets/images/logo/VOD.png',
    'assets/images/logo/netflix.png',
    'assets/images/logo/prime_video.png',
    'assets/images/logo/disney+.png',
    'assets/images/logo/apple_tv+.png',
    'assets/images/logo/mycanal.png',
    'assets/images/logo/autre_sources.png'
  ];

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      final Map<String, bool> viewingPlatform =
          context.read<FormBloc>().state.viewingPlatform;
      // When I create this variable,
      // only god and I knew how it worked. Now, only god knows it
      final Map<String, String> checkboxImages = Map.fromEntries(
          viewingPlatform.entries.map((entry) => MapEntry(
              entry.key,
              _imagesList[viewingPlatform.keys.toList().indexOf(entry.key)])));

      context.read<FormBloc>().add(const EmitEvent(status: FormStatus.viewingPlatform));
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: Tools.heightFactor(context, 0.10)),
          const PageIndicator(currentPage: 2, pageCount: 3),
          SizedBox(height: Tools.heightFactor(context, 0.05)),
          Center(
            child: SizedBox(
              width: Tools.widthFactor(context, 0.45),
              child: AutoSizeText(
                'SUPPORT DE VISIONNAGE :',
                maxLines: 2,
                minFontSize: 18.0,
                maxFontSize: 24.0,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SizedBox(height: Tools.heightFactor(context, 0.03)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 65.0),
              child: FormCheckbox(
                checkboxList: viewingPlatform,
                checkboxImages: checkboxImages,
                event: const ViewingPlatformEvent(key: 'h'),
              )
            ),
          )
        ],
      );
    });
  }
}
