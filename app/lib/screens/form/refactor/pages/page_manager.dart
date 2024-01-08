/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/refactor/bloc/form_bloc.dart';
import 'package:getout/screens/form/refactor/pages/social_media_time.dart';
import 'package:getout/screens/form/refactor/pages/literary_genre.dart';
import 'package:getout/screens/form/refactor/pages/interest_choices.dart';
import 'package:getout/screens/form/refactor/pages/film_genres.dart';
import 'package:getout/screens/form/refactor/pages/viewing_platform.dart';

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context)
  {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => FormBloc(),
      child: Scaffold(
            appBar: AppBar(
              title: const Text('VOS PRÉFÉRENCES'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
              )
            ),
            body: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const <Widget> [
                    SocialMediaSpentTime(),
                    InterestChoices(),
                    LiteraryGenres(),
                    FilmGenres(),
                    ViewingPlatform(),
                    // EndForm(),
                  ],
                ),
            floatingActionButton: _nextButton(pageController),
          ),
    );
  }

  Widget _nextButton(final PageController pageController)
  {
    return BlocBuilder<FormBloc, FormStates>(builder: (context, state)
    {
      return SizedBox(
        width: 90 * MediaQuery.of(context).size.width / 100,
        height: 65,
        child: FloatingActionButton(
          child: Text('Suivant', style: Theme.of(context).textTheme.labelMedium),
          onPressed: () {
            if ((context.read<FormBloc>().state.status == FormStatus.socialMediaTime && context.read<FormBloc>().state.time == 0.0) ||
                (context.read<FormBloc>().state.status == FormStatus.interestChoices && !context.read<FormBloc>().state.interest.contains(true)) ||
                (context.read<FormBloc>().state.status == FormStatus.literaryGenres && !context.read<FormBloc>().state.literaryGenres.contains(true)) ||
                (context.read<FormBloc>().state.status == FormStatus.filmGenres && !context.read<FormBloc>().state.filmGenres.contains(true)) ||
                (context.read<FormBloc>().state.status == FormStatus.viewingPlatform && !context.read<FormBloc>().state.viewingPlatform.contains(true))) {
              return _showSnackBar(context, 'Veuillez remplir tous les champs');
            }
            pageController.nextPage(
                duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
            },
        ),
      );
    });
  }

  void _showSnackBar(final BuildContext context, final String message)
  {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message,
            style: Theme.of(context).textTheme.displaySmall
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}