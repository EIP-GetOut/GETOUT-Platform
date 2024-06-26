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
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/tools.dart';

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
          SizedBox(height: Tools.heightFactor(context, 0.03)),
          PageTitle(
            title: appL10n(context)!.literary_genre,
            description: appL10n(context)!.form_description,
          ),
          SizedBox(height: Tools.heightFactor(context, 0.06)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
              child: const ProgressBar(total: 3, current: 1)),
          SizedBox(height: Tools.heightFactor(context, 0.05)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 65.0),
              child: FormCheckbox(
                checkboxList: context.read<FormBloc>().state.literaryGenres,
                checkboxImages: null,
                event: const LiteraryGenresEvent(key: ''),
              )
            ),
          )
        ],
      );
    });
  }
}
