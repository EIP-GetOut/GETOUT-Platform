/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/form/services/form_services.dart';
import 'package:getout/screens/form/pages/viewing_platform.dart';
// import 'package:getout/screens/form/pages/social_media_time.dart';
// import 'package:getout/screens/form/pages/interest_choices.dart';
import 'package:getout/screens/form/pages/literary_genre.dart';
import 'package:getout/screens/form/pages/film_genres.dart';
import 'package:getout/screens/form/pages/end_form.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/tools/tools.dart';
import 'package:getout/global.dart' as globals;

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => FormBloc(),
      child: Scaffold(
        appBar: AppBar(
            leading: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            )),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[
            // SocialMediaSpentTime(),
            // InterestChoices(),
            LiteraryGenres(),
            FilmGenres(),
            ViewingPlatform(),
            EndForm(),
          ],
        ),
        floatingActionButton: _nextButton(pageController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _nextButton(final PageController pageController) {
    bool isEdit = false;
    if (globals.session?['preferences'] != null) {
      isEdit = true;
    }

    return BlocBuilder<FormBloc, FormStates>(builder: (context, state) {
      return SizedBox(
        width: Tools.widthFactor(context, 0.9),
        height: 65,
        child: FloatingActionButton(
          child: (context.read<FormBloc>().state.status ==
              FormStatus.endForm) ?
          Text('Découvrir l\'application',
              style: Theme.of(context).textTheme.labelMedium)
              : AutoSizingText('Suivant',
              minSize: 70,
              maxSize: 100,
              sizeFactor: 0.12,
              height: 40,
              style: Theme.of(context).textTheme.labelMedium),
          onPressed: () {
            if (
                /*(context.read<FormBloc>().state.status == FormStatus.interestChoices &&
                    !context.read<FormBloc>().state.interest.containsValue(true)) ||*/
                (context.read<FormBloc>().state.status ==
                            FormStatus.literaryGenres &&
                        !context
                            .read<FormBloc>()
                            .state
                            .literaryGenres
                            .containsValue(true)) ||
                    (context.read<FormBloc>().state.status ==
                            FormStatus.filmGenres &&
                        !context
                            .read<FormBloc>()
                            .state
                            .filmGenres
                            .containsValue(true)) ||
                    (context.read<FormBloc>().state.status ==
                            FormStatus.viewingPlatform &&
                        !context
                            .read<FormBloc>()
                            .state
                            .viewingPlatform
                            .containsValue(true))) {
              showSnackBar(context, 'Veuillez sélectionner au moins une case');
            } else if (context.read<FormBloc>().state.status ==
                FormStatus.endForm) {
              FormServices()
                  .sendPreferences(FormRequestModel.fillFormRequest(
                      filmGenres: context.read<FormBloc>().state.filmGenres,
                      literaryGenres:
                          context.read<FormBloc>().state.literaryGenres,
                      viewingPlatform:
                          context.read<FormBloc>().state.viewingPlatform))
                  .then((final FormResponseModel value) {
                if (!value.isSuccessful) {
                  showSnackBar(context,
                      'Une erreur est survenue veuillez réessayer plus tard');
                }
                if (isEdit) {
                  Navigator.pop(context);
                }
                context.read<SessionBloc>().add(const SessionRequest());
              });
            } else {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            }
          },
        ),
      );
    });
  }
}
