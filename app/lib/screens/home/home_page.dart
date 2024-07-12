/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/children/dashboard/pages/dashboard.dart';
import 'package:getout/screens/home/children/your_books/pages/your_books.dart';
import 'package:getout/screens/home/children/your_movies/pages/your_movies.dart';
import 'package:getout/screens/home/widgets/header.dart';
import 'package:getout/screens/home/widgets/navbar.dart';
import 'package:getout/global.dart' as globals;

/// UserPage
///  - UserAppBar()
///  - PageView
///    - DashboardLayout
///    - YourMovie
///    - YourBooks
///  - BottomNavBar
///
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ValueNotifier<int> index = ValueNotifier(0);

    globals.notificationsServices.askForActiveNotifications();
    return Scaffold(
          appBar: HomeAppBarWidget(context: context),
          body: PageView(
            controller: pageController,
            onPageChanged: (value) {
              index.value = value;
            },
            children: <Widget>[
              ListView(children: const [
                SizedBox(height: 600, child: DashboardPage())
              ]),
              ListView(children: const [
                SizedBox(height: 900, child: YourMoviesPage())
              ]),
              ListView(children: const [
                SizedBox(height: 900, child: YourBooksPage())
              ])
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder<int>(
    valueListenable: index,
    builder: (context, value, child) {
      return HomeNavBarWidget(
              pageController: pageController, idx: index);
    }));
  }
}
