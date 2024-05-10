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


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {

      return Scaffold(
          appBar: AppBar(
            title: const Text('History'),
            leading: const BackButton(),
          ),
          body: ListView(
              padding: const EdgeInsets.only(top: 24),
              children: [const HistoryRow(value: 'Books', background: true, title: true),
                          ...List.generate(state.recommendedBooks.length, (index) => HistoryRow(value: state.recommendedBooks[index].title, background: index.isOdd)),
                          const HistoryRow(value: 'Movies', background: true, title: true),
                          ...List.generate(state.recommendedMovies.length, (index) => HistoryRow(value: state.recommendedMovies[index].title, background: index.isOdd))]
          )
      );
    });
  }
}
