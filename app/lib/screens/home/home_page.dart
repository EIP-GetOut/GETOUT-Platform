/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/home_page/home_page_bloc.dart';
import 'package:getout/screens/home/children/dashboard/pages/dashboard.dart';
import 'package:getout/screens/home/children/your_books/pages/your_books.dart';
import 'package:getout/screens/home/children/your_movies/pages/your_movies.dart';
// import 'package:getout/screens/home/widgets/header.dart';
import 'package:getout/screens/home/widgets/dashboard/refresh_time.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news_card.dart';
import 'package:getout/screens/home/widgets/dashboard/spent_time.dart';
import 'package:getout/screens/home/widgets/dashboard/news_card.dart';
import 'package:getout/screens/home/widgets/navbar.dart';
import 'package:getout/screens/settings/settings.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/global.dart' as globals;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    globals.notificationsServices.askForActiveNotifications();
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(appL10n(context)!.homepage_title,
                          style: Theme.of(context).textTheme.titleLarge)),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(appL10n(context)!.homepage_subtitle,
                          style: Theme.of(context).textTheme.displayMedium)),
                ])
              ],
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      icon: const Icon(Icons.settings, size: 40),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsPage()));
                      })),
            ],
          ),

          // HomeAppBarWidget(context: context),
          body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                context.read<HomePageBloc>().add(HomePageToIdx(index));
              },
              children: const [
                Column(
                  children: [
                    RefreshTimeCard(),
                    NewsCard(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpentTimeCard(
                            title: 'Total Livre',
                            icon: Icons.book,
                            number: '802 pages'),
                        SpentTimeCard(
                            title: 'Total Film',
                            icon: Icons.movie,
                            number: '5h39'),
                      ],
                    ),
                    StoryNewsCard()
                  ],
                )
              ]),
          bottomNavigationBar:
              HomeNavBarWidget(pageController: pageController, idx: state.idx));
    });
  }
}
