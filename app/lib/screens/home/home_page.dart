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
import 'package:getout/screens/home/children/dashboard/pages/dashboard.dart';
import 'package:getout/screens/home/children/your_books/pages/your_books.dart';
import 'package:getout/screens/home/children/your_movies/pages/your_movies.dart';
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
              children: const <Widget>[
<<<<<<< HEAD
                Dashboard(),
=======
                DashboardPage(),
>>>>>>> origin/app
                YourMoviesPage(),
                YourBooksPage(),
              ]),
          bottomNavigationBar:
              HomeNavBarWidget(pageController: pageController, idx: state.idx));
    });
  }
}
