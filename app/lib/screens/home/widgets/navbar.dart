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
import 'package:getout/tools/app_l10n.dart';

class HomeNavBarWidget extends StatelessWidget {
  const HomeNavBarWidget(
      {super.key, required this.pageController, required this.idx});

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
                icon: SvgPicture.asset('assets/images/icon/movie.svg',
                    width: 40,
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset('assets/images/icon/movie.svg',
                    width: 40,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: appL10n(context)!.movie),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/home.svg',
                    width: 40,
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset('assets/images/icon/home.svg',
                    width: 40,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: appL10n(context)!.dashboard),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/book.svg',
                    width: 40,
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset('assets/images/icon/book.svg',
                    width: 40,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)),
                label: appL10n(context)!.book),
            //todo implement activities
            /*BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon/location_pin.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.srcIn)),
                activeIcon: SvgPicture.asset(
                    'assets/images/icon/location_pin.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.red, BlendMode.srcIn)),
                label: 'Activities')*/
          ],
          elevation: 20,
          onTap: (int value) => {
            context.read<HomePageBloc>().add(HomePageToIdx(value)),
            pageController.animateToPage(value,
                duration: const Duration(milliseconds: 1),
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
