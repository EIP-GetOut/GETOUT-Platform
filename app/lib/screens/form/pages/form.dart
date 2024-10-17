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
import 'package:getout/screens/form/pages/book_genre.dart';
import 'package:getout/screens/form/pages/movie_genres.dart';
import 'package:getout/screens/form/pages/end_form.dart';
import 'package:getout/screens/form/bloc/form_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/tools/app_l10n.dart';

class Forms extends StatelessWidget {

  final bool isEdit;

  const Forms({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => FormBloc(),
      child: BlocBuilder<FormBloc, FormStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: _backButton(pageController, state, context),
          ),
          body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BookGenres(formContext: context),
                MovieGenres(formContext: context),
                ViewingPlatform(formContext: context),
                EndForm(formContext: context),
              ]),
          floatingActionButton: _nextButton(pageController, context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  Widget _backButton(final PageController pageController,
      final FormStates state, final BuildContext context) {

    if (!isEdit && state.status == FormStatus.bookGenres) {
      return SizedBox();
    }
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (!isEdit ||
              (state.status != FormStatus.endForm && // last page
                  state.status != FormStatus.bookGenres && // first page
                  state.status != FormStatus.loading)) {
            pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          } else {
            Navigator.pop(context);
          }
        });
  }

  String _getButtonLabel(final FormStatus status, BuildContext context) {
    if (status == FormStatus.endForm && isEdit) {
      return appL10n(context)!.back_to_settings;
    } else if (status == FormStatus.endForm) {
      return appL10n(context)!.discover_app;
    } else if (status == FormStatus.viewingPlatform) {
      return appL10n(context)!.confirm;
    }
    return appL10n(context)!.next;
  }

  Widget _nextButton(
      final PageController pageController, final BuildContext context) {
    final FormStatus status = context.read<FormBloc>().state.status;
    final FormBloc readContext = context.read<FormBloc>();

    return (status == FormStatus.loading)
        ? const CircularProgressIndicator()
        : DefaultButton(
            title: _getButtonLabel(readContext.state.status, context),
            onPressed: () {
              if ((status == FormStatus.bookGenres &&
                      !readContext.state.bookGenres.containsValue(true)) ||
                  (status == FormStatus.movieGenres &&
                      !readContext.state.movieGenres.containsValue(true)) ||
                  (status == FormStatus.viewingPlatform &&
                      !readContext.state.viewingPlatform.containsValue(true))) {
                showSnackBar(context, appL10n(context)!.form_empty);
              } else if ((status == FormStatus.bookGenres &&
                  readContext.state.bookGenres.values.where((value) => value == true).length > 3) ||
                  (status == FormStatus.movieGenres &&
                      readContext.state.movieGenres.values.where((value) => value == true).length > 3) ||
                  (status == FormStatus.viewingPlatform &&
                      readContext.state.viewingPlatform.values.where((value) => value == true).length > 3)) {
                showSnackBar(context, appL10n(context)!.form_too_much);
              } else if (status == FormStatus.viewingPlatform) {
                readContext.add(const EmitEvent(status: FormStatus.loading));
                FormServices()
                    .sendPreferences(FormRequestModel.fillFormRequest(
                        movieGenres: readContext.state.movieGenres,
                        bookGenres: readContext.state.bookGenres,
                        viewingPlatform: readContext.state.viewingPlatform))
                    .then((final FormResponseModel value) {
                  if (!value.isSuccessful && context.mounted) {
                    readContext
                        .add(const EmitEvent(status: FormStatus.viewingPlatform));
                    return showSnackBar(
                        context, appL10n(context)!.error_unknown);
                  }
                  if (context.mounted) {
                    readContext
                        .add(const EmitEvent(status: FormStatus.endForm));
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  }
                });
              } else if (status == FormStatus.endForm) {
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
  }
}
