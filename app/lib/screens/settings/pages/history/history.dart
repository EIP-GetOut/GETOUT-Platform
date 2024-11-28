/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/history/history_bloc.dart';
import 'package:getout/screens/settings/pages/history/history_row.dart';
import 'package:getout/widgets/transition_page.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/tools/tools.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
      if (state.status.isLoading) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Center(
            child: SizedBox(
              height: Tools.heightFactor(context, 0.15),
                width: Tools.heightFactor(context, 0.15),
                child: const CircularProgressIndicator()),
          ),
        );
      } else if (state.status.isError) {
        return TransitionPage(
            title: appL10n(context)!.error_unknown_short,
            description: appL10n(context)!.error_unknown_description,
            image: 'assets/images/draw/error.svg',
            buttonText: appL10n(context)!.error_ok,
            nextPage: () => {
              Navigator.pop(context),
            });
      }
      return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Column(
            children: [
              PageTitle(
                title: appL10n(context)!.history,
                description: 'Retrouvez ici votre historique de recommandation', // TODO : put in l10n
              ),
              SizedBox(height: Tools.heightFactor(context, 0.04)),
              Expanded(
                child: ListView(padding: const EdgeInsets.only(top: 24), children: [
                  HistoryRow(value: appL10n(context)!.book, background: true, title: true),
                  ...List.generate(
                      state.recommendedBooks.length,
                          (index) => HistoryRow(
                          value: state.recommendedBooks[index].title,
                          background: index.isOdd)),
                  HistoryRow(value: appL10n(context)!.movie, background: true, title: true),
                  ...List.generate(
                      state.recommendedMovies.length,
                          (index) => HistoryRow(
                          value: state.recommendedMovies[index].title,
                          background: index.isOdd))
                ]),
              ),
            ],
          ));
    });
  }
}