/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:getout/screens/home/bloc/home_page/home_page_bloc.dart';


class HomeNavBarWidget extends StatelessWidget {
  const HomeNavBarWidget({super.key, required this.pageController, required this.idx});

  final PageController pageController;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/home.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset('assets/images/icon/home.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.red, BlendMode.srcIn)),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/movie.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset('assets/images/icon/movie.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.red, BlendMode.srcIn)),
                label: 'Movie'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/bookmark.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset(
                    'assets/images/icon/bookmark.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.red, BlendMode.srcIn)),
                label: 'Book'),
            //todo implement activities
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/location_pin.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset(
                    'assets/images/icon/location_pin.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.red, BlendMode.srcIn)),
                label: 'Activities')
          ],
          elevation: 20,
          onTap: (int value) => {
            context.read<HomePageBloc>().add(HomePageToIdx(value)),
            pageController.animateToPage(value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn),
          },
          showUnselectedLabels: true,
          selectedLabelStyle:
          const TextStyle(fontFamily: 'Urbanist', fontSize: 16),
          unselectedLabelStyle:
          const TextStyle(fontFamily: 'Urbanist', fontSize: 12),
          unselectedItemColor: Colors.black26,
          selectedItemColor: Colors.red,
          currentIndex: idx,
        ));
  }
}