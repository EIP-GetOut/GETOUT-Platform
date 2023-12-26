/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/home/bloc/home_page_bloc.dart';
import 'package:getout/screens/home/children/dashboard/pages/dashboard.dart';
import 'package:getout/screens/home/widgets/header.dart';
import 'package:getout/screens/home/widgets/navbar.dart';

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
          appBar: UserAppBar(context: context),
          body: PageView(
            //physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              context.read<HomePageBloc>().add(HomePageToIdx(index));
            },
            children: <Widget>[
              ListView(children: const [
                SizedBox(height: 800, child: DashboardLayout())
              ]),
              ListView(children: [
                SizedBox(
                    width: 1000,
                    height: 1000,
                    child: ColoredBox(
                        color: Colors.green,
                        child: Text('Movie1/2 ${state.idx}'))),
                SizedBox(
                    width: 1000,
                    height: 1000,
                    child: ColoredBox(
                        color: Colors.yellow,
                        child: Text('Movie2/2 ${state.idx}')))
              ]),
              SizedBox(
                  width: 1000,
                  height: 2000,
                  child: ColoredBox(
                      color: Colors.red,
                      child: Text('Book ${state.idx}'))),
              SizedBox(
                  width: 1000,
                  height: 2000,
                  child: ColoredBox(
                      color: Colors.blue,
                      child: Text('Activities ${state.idx}')))
            ],
          ),
          bottomNavigationBar: UserNavBar(pageController: _pageController, idx: state.idx));
    });
  }
}
