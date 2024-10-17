/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_bloc.dart';
import 'package:getout/screens/home/children/dashboard/pages/dashboard_shimmer.dart';
import 'package:getout/screens/home/children/dashboard/pages/dashboard_page.dart';
import 'package:getout/widgets/transition_page.dart';
import 'package:getout/tools/app_l10n.dart';

class Dashboard extends StatelessWidget {
  final PageController pageController;
  final ScrollController movieController;
  final ScrollController bookController;

  const Dashboard({super.key, required this.pageController, required this.movieController, required this.bookController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryNewsBloc, StoryNewsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const DashboardShimmer();
        } else if (state.status.isError) {
          Future.microtask(() {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransitionPage(
                          title: appL10n(context)!.error_unknown_short,
                          description: appL10n(context)!
                              .error_unknown_description,
                          image: 'assets/images/draw/error.svg',
                          buttonText: appL10n(context)!.error_ok,
                          nextPage: () =>
                          {
                            Phoenix.rebirth(context),
                          }),
                ),
              );
            }
          });
          return const SizedBox.shrink();
        } else {
          return DashboardPage(pageController: pageController ,
              movieController: movieController,
              bookController: bookController);
        }
      },
    );
  }
}
