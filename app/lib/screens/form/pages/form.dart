/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/constants/movie_genre.dart';

import 'package:getout/screens/form/childrens/viewing_platform.dart';
import 'package:getout/screens/form/childrens/book_genre.dart';
import 'package:getout/screens/form/childrens/movie_genres.dart';
import 'package:getout/screens/form/childrens/end_form.dart';

import 'package:getout/bloc/user/user_bloc.dart';
import 'package:getout/screens/form/services/form_service.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/tools.dart';

import 'package:getout/tools/map_controller.dart';

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final Account? account = context.read<UserBloc>().state.account;
     account?.moviesGenres;
     account?.booksGenres;
     account?.platforms;
    final MapController<String, bool> bookGenres = MapController({
      'Polar': account?.booksGenres.contains('Polar') ?? false,
      'Poésie': account?.booksGenres.contains('Poésie') ?? false,
      'Thriller': account?.booksGenres.contains('Thriller') ?? false,
      'Politique': account?.booksGenres.contains('Politique') ?? false,
      'Comédie': account?.booksGenres.contains('Comédie') ?? false
    });
    final MapController<String, bool> movieGenres = MapController({
      'Action': account?.moviesGenres.contains(MovieGenre['Action']) ?? false,
      'Thriller': account?.moviesGenres.contains(MovieGenre['Thriller']) ?? false,
      'Western': account?.moviesGenres.contains(MovieGenre['Western']) ?? false,
      'Horreur': account?.moviesGenres.contains(MovieGenre['Horreur']) ?? false,
      'Comédie': account?.moviesGenres.contains(MovieGenre['Comédie']) ?? false
    });
    final MapController<String, bool> platforms = MapController({
      'Netflix': account?.platforms.contains('Netflix') ?? false,
      'Prime Video': account?.platforms.contains('Prime Video') ?? false,
      'Disney +': account?.platforms.contains('Disney +') ?? false,
      'Cinema': account?.platforms.contains('Cinema') ?? false,
      'DVD': account?.platforms.contains('DVD') ?? false
    });

    return Scaffold(
      appBar: AppBar(
          //title: const Text('VOS PRÉFÉRENCES'),
          title: const AutoSizeText('VOS PRÉFÉRENCES',
              maxLines: 1, minFontSize: 16.0, maxFontSize: 32.0),
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
        children: [
          BookGenres(bookGenres: bookGenres),
          MovieGenres(movieGenres: movieGenres),
          ViewingPlatform(platforms: platforms),
          const EndForm(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: NextButton(
        pageController: pageController,
        bookGenres: bookGenres,
        movieGenres: movieGenres,
        platforms: platforms,
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final PageController pageController;
  final MapController<String, bool> bookGenres;
  final MapController<String, bool> movieGenres;
  final MapController<String, bool> platforms;

  const NextButton(
      {super.key,
      required this.pageController,
      required this.bookGenres,
      required this.movieGenres,
      required this.platforms});

  @override
  Widget build(BuildContext context) {
    FormService formService =
        FormService(context.watch<UserBloc>().state.cookiePath);
    // TODO: implement build
    return SizedBox(
      width: Tools.widthFactor(context, 0.9),
      height: 65,
      child: FloatingActionButton(
        child: AutoSizingText('Suivant',
            minSize: 70,
            maxSize: 100,
            sizeFactor: 0.12,
            height: 40,
            style: Theme.of(context).textTheme.labelMedium),
        onPressed: () async {
          if (pageController.page == 3) {
          } else if (pageController.page == 2 &&
              platforms.containsValue(true)) {
            //todo request
            try {
              print('t');
              FormRequestModel formRequestModel =
              FormRequestModel.fillFormRequest(
                  movieGenres: movieGenres.unmodifiable,
                  bookGenres: bookGenres.unmodifiable,
                  platforms: platforms.unmodifiable);
              print('g');
              Response response =
                  await formService.sendPreferences(formRequestModel, /*isFirstTime: true*/);
              print('v');
              if (response.statusCode == 200) {
                context.read<UserBloc>().add(PreferenceEvent(
                    movieGenres: formRequestModel.movieGenres,
                    bookGenres: formRequestModel.bookGenres,
                    platforms: formRequestModel.platforms));
                print('y');
                pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              }
            } catch (e) {
              if (e is DioException) {
                switch (e.response?.statusCode) {
                  case 400:
                    showSnackBar(context, 'vous n\'êtes pas connecter');
                    break;
                  case 409: //conflict => preference already exist
                    showSnackBar(context, 'les préférences sont déjà initialisé');
                    break;
                  case 500:
                  case 404: /*internal server error*/ //account does not exist => not found
                    showSnackBar(context, appL10n(context)!.error_unknow);
                    break;
                }
              } else {}
            }
          } else if ((pageController.page == 0 &&
                  bookGenres.containsValue(true)) ||
              (pageController.page == 1 && movieGenres.containsValue(true))) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          } else {
            showSnackBar(context, 'Veuillez sélectionner au moins une case');
          }
        },
      ),
    );
  }
}
