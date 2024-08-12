/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/home_page/home_page_bloc.dart';
import 'package:getout/screens/home/widgets/header.dart';
import 'package:getout/screens/home/widgets/dashboard/refresh_time.dart';
import 'package:getout/screens/home/widgets/dashboard/story_news_card.dart';
import 'package:getout/screens/home/widgets/dashboard/spent_time.dart';
import 'package:getout/screens/home/widgets/dashboard/news_card.dart';
import 'package:getout/screens/home/widgets/navbar.dart';
import 'package:getout/global.dart' as globals;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    globals.notificationsServices.askForActiveNotifications();
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      return Scaffold(
          appBar: HomeAppBarWidget(context: context),
          body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                context.read<HomePageBloc>().add(HomePageToIdx(index));
              },
              children: const [
                SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10,bottom : 10),
                        child: Column(
                          children: [
                            RefreshTimeCard(),
                            Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: NewsCard()),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SpentTimeCard(
                                        title: 'Total Livre',
                                        icon: Icons.book,
                                        number: '802 pages'),
                                                  SizedBox(width: 30),

                                    SpentTimeCard(
                                        title: 'Total Film',
                                        icon: Icons.movie,
                                        number: '5h39'),
                                  ],
                                )),
                            StoryNewsCard()
                          ],
                        )))
              ]),
          bottomNavigationBar:
              HomeNavBarWidget(pageController: pageController, idx: state.idx));
    });
  }
}
