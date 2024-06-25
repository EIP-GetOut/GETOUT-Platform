/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/constants/movie_genre.dart';
import 'package:getout/global.dart' as globals;

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStates> {
  FormBloc() : super(const FormStates())
  {
    final List<String> filmGenre = filmCodesToGenres(globals.session?['preferences']['moviesGenres']);
    final List<String> literaryGenre = literaryCodesToGenres(globals.session?['preferences']['booksGenres']);

    on<EmitEvent>((event, emit) => emit(state.copyWith(status: event.status)));
    // on<SocialMediaTimeEvent>((event, emit) => emit(state.copyWith(time: event.time)));
    // on<InterestChoicesEvent>(_interestChoices);
    on<LiteraryGenresEvent>(_literaryGenresEvent);
    on<FilmGenresEvent>(_filmGenresEvent);
    on<ViewingPlatformEvent>(_viewingPlatformEvent);
    on<EndFormEvent>((event, emit) => emit(state.copyWith()));
    on<ErrorEvent>((event, emit) => emit(state.copyWith()));

    for (String genre in filmGenre) {
      add(FilmGenresEvent(key: genre));
    }
    for (String genre in literaryGenre) {
      add(LiteraryGenresEvent(key: genre));
    }
    for (String platform in globals.session?['preferences']['platforms']) {
      add(ViewingPlatformEvent(key: platform));
    }
  }
  // filmCodes is dynamic because session['preferences']['moviesGenres'] is a List<dynamic>
  static List<String> filmCodesToGenres(final List<dynamic> filmCodes)
  {
    Map<int, String> genreByCode = FilmGenreList.map((key, value) => MapEntry(value, key));

    return filmCodes.map((code) => genreByCode[code] ?? 'Unknown').toList();
  }

  // literaryCodes is dynamic because session['preferences']['literaryGenres'] is a List<dynamic>
  static List<String> literaryCodesToGenres(final List<dynamic> literaryCodes)
  {
    Map<String, String> genreByCode = LiteraryGenreList.map((key, value) => MapEntry(value, key));

    return literaryCodes.map((code) => genreByCode[code] ?? 'Unknown').toList();
  }

  /*void _interestChoices(InterestChoicesEvent interestChoices, Emitter<FormStates> emit) async
  {
    Map<String, bool> interestList = Map.from(state.interest);
    interestList[interestChoices.key] = !interestList[interestChoices.key]!;
    emit(state.copyWith(interest: interestList));
  }*/

  void _literaryGenresEvent(LiteraryGenresEvent literaryGenresEvent, Emitter<FormStates> emit) async
  {
    Map<String, bool> listGenres = Map.from(state.literaryGenres);
    listGenres[literaryGenresEvent.key] = !listGenres[literaryGenresEvent.key]!;
    emit(state.copyWith(literaryGenres: listGenres));
  }

  void _filmGenresEvent(FilmGenresEvent filmGenresEvent, Emitter<FormStates> emit) async
  {
    Map<String, bool> filmList = Map.from(state.filmGenres);
    filmList[filmGenresEvent.key] = !filmList[filmGenresEvent.key]!;
    emit(state.copyWith(filmGenres: filmList));
  }

  void _viewingPlatformEvent(ViewingPlatformEvent viewingPlatformEvent, Emitter<FormStates> emit) async
  {
    Map<String, bool> viewingPlatformList = Map.from(state.viewingPlatform);
    viewingPlatformList[viewingPlatformEvent.key] = !viewingPlatformList[viewingPlatformEvent.key]!;
    emit(state.copyWith(viewingPlatform: viewingPlatformList));
  }
}
