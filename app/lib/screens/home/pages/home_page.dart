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
import 'package:getout/screens/home/widgets/header.dart';
import 'package:getout/screens/home/widgets/navbar.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';

/// UserPage
///  - UserAppBar()
///  - PageView
///    - DashboardLayout
///    - YourMovie
///    - YourBooks
///  - BottomNavBar
///
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      return Scaffold(
          appBar: HomeAppBarWidget(context: context),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<HomePageBloc>().add(HomePageToIdx(index));
            },
            children: <Widget>[
              ListView(children: const [
                SizedBox(height: 800, child: DashboardPage())
              ]),
              ListView(children: const [
                SizedBox(height: 1000, child: YourMoviesPage())
              ]),
              ListView(children: const [
                SizedBox(height: 1000, child: YourBooksPage())
              ]),
              const SizedBox(
                  width: 1000,
                  height: 2000,
                  child: ColoredBox(
                      color: Colors.white, child: ObjectLoadingErrorWidget(object: 'Les Activités')))
            ],
          ),
          bottomNavigationBar: HomeNavBarWidget(
              pageController: _pageController, idx: state.idx));
    });
  }
}
