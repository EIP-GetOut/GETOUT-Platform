/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/widgets/dashboard/refresh_time.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_bloc.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_card.dart';
import 'package:getout/screens/home/widgets/dashboard/spent_time.dart';
import 'package:getout/screens/home/widgets/dashboard/news/news_card.dart';
import 'package:getout/tools/duration_format.dart';
import 'package:getout/global.dart' as globals;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryNewsBloc, StoryNewsState>(builder: (context, state) {
      return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  const RefreshTimeCard(),
                  const Padding(
                      padding: EdgeInsets.only(top: 10), child: NewsCard()),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpentTimeCard(
                              title: 'Total Livre',
                              icon: Icons.book,
                              number:
                                  '${globals.session?['totalPagesRead']} pages'),
                          const SizedBox(width: 30),
                          SpentTimeCard(
                              title: 'Total Film',
                              icon: Icons.movie,
                              number: durationFormat('',
                                  globals.session?['spentMinutesWatching'])),
                        ],
                      )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: StoryNewsCard())
                ],
              )));
    });
  }
}
