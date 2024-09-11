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
import 'package:getout/screens/form/pages/book_genre.dart';
import 'package:getout/screens/form/pages/movie_genres.dart';
import 'package:getout/screens/form/pages/end_form.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/global.dart' as globals;

class Forms extends StatelessWidget {
  const Forms({super.key});

  static const List<Widget> pages = [
    // SocialMediaSpentTime(),
    // InterestChoices(),
    BookGenres(),
    MovieGenres(),
    ViewingPlatform(),
    EndForm(),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => FormBloc(),
      child: BlocBuilder<FormBloc, FormStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading:
                (context.read<FormBloc>().state.status != FormStatus.endForm)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        },
                      )
                    : null,
          ),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: pages,
          ),
          floatingActionButton: _nextButton(pageController),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  String _getButtonLabel(
      final FormStatus status, final bool isEdit, BuildContext context) {
    if (status == FormStatus.endForm && isEdit) {
      return appL10n(context)!.back_to_settings;
    } else if (status == FormStatus.endForm) {
      return appL10n(context)!.discover_app;
    } else if (status == FormStatus.viewingPlatform) {
      return appL10n(context)!.confirm;
    }
    return appL10n(context)!.next;
  }

  Widget _nextButton(final PageController pageController) {
    final bool isEdit = (globals.session?['preferences'] != null);

    return BlocBuilder<FormBloc, FormStates>(builder: (context, state) {
      return DefaultButton(
          title: _getButtonLabel(
              context.read<FormBloc>().state.status, isEdit, context),
          onPressed: () {
            if (
                /*(context.read<FormBloc>().state.status == FormStatus.interestChoices &&
                    !context.read<FormBloc>().state.interest.containsValue(true)) ||*/
                (context.read<FormBloc>().state.status ==
                            FormStatus.bookGenres &&
                        !context
                            .read<FormBloc>()
                            .state
                            .bookGenres
                            .containsValue(true)) ||
                    (context.read<FormBloc>().state.status ==
                            FormStatus.movieGenres &&
                        !context
                            .read<FormBloc>()
                            .state
                            .movieGenres
                            .containsValue(true)) ||
                    (context.read<FormBloc>().state.status ==
                            FormStatus.viewingPlatform &&
                        !context
                            .read<FormBloc>()
                            .state
                            .viewingPlatform
                            .containsValue(true))) {
              showSnackBar(context, appL10n(context)!.form_validator);
            } else if (context.read<FormBloc>().state.status ==
                FormStatus.viewingPlatform) {
              FormServices()
                  .sendPreferences(FormRequestModel.fillFormRequest(
                      movieGenres: context.read<FormBloc>().state.movieGenres,
                      bookGenres: context.read<FormBloc>().state.bookGenres,
                      viewingPlatform:
                          context.read<FormBloc>().state.viewingPlatform))
                  .then((final FormResponseModel value) {
                if (!value.isSuccessful && context.mounted) {
                  return showSnackBar(context, appL10n(context)!.error_unknown);
                }
                if (context.mounted) {
                  context
                      .read<FormBloc>()
                      .add(const EmitEvent(status: FormStatus.endForm));
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                }
              });
            } else if (context.read<FormBloc>().state.status ==
                FormStatus.endForm) {
              if (isEdit) {
                Navigator.pop(context);
              }
              context.read<SessionBloc>().add(const SessionRequest());
            } else {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            }
          });
    });
  }
}
