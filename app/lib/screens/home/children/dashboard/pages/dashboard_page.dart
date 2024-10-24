/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/widgets/dashboard/refresh_time.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_bloc.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_card.dart';
import 'package:getout/screens/home/widgets/dashboard/spent_time.dart';
import 'package:getout/screens/home/widgets/dashboard/news/news_card.dart';
import 'package:getout/tools/duration_format.dart';

import 'package:getout/tools/app_l10n.dart';

import 'package:getout/global.dart' as globals;

class DashboardPage extends StatelessWidget {
  final PageController pageController;
  final ScrollController movieController;
  final ScrollController bookController;

  const DashboardPage(
      {super.key,
      required this.pageController,
      required this.movieController,
      required this.bookController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryNewsBloc, StoryNewsState>(
        builder: (context, state) {
      return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  const RefreshTimeCard(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () => {
                                pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linearToEaseOut).then((_) =>
                                    movieController.animateTo(20000,
                                        duration: Duration(milliseconds: 600),
                                        curve: Curves.easeIn))
                              },
                          child: SpentTimeCard(
                              title: appL10n(context)!.total_movie,
                              icon: Icons.movie,
                              number: durationFormat('',
                                  globals.session?['spentMinutesWatching']))),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onTap: () => {
                                pageController.animateToPage(2,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linearToEaseOut).then((_) =>
                                bookController.animateTo(20000,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeIn))
                              },
                          child: SpentTimeCard(
                              title: appL10n(context)!.total_book,
                              icon: Icons.book,
                              number:
                                  '${globals.session?['totalPagesRead']} pages')),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: NewsCard()),
                  const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: StoryNewsCard())
                ],
              )));
    });
  }
}
