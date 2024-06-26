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
    on<EmitEvent>((event, emit) => emit(state.copyWith(status: event.status)));
    // on<SocialMediaTimeEvent>((event, emit) => emit(state.copyWith(time: event.time)));
    // on<InterestChoicesEvent>(_interestChoices);
    on<BookGenresEvent>(_bookGenresEvent);
    on<MovieGenresEvent>(_movieGenresEvent);
    on<ViewingPlatformEvent>(_viewingPlatformEvent);
    on<EndFormEvent>((event, emit) => emit(state.copyWith()));
    on<ErrorEvent>((event, emit) => emit(state.copyWith()));
    if (globals.session == null || globals.session?['preferences'] == null) {
      return;
    }
    for (String genre in movieCodesToGenres(globals.session?['preferences']['moviesGenres'])) {
      add(MovieGenresEvent(key: genre));
    }
    for (String genre in bookCodesToGenres(globals.session?['preferences']['booksGenres'])) {
      add(BookGenresEvent(key: genre));
    }
    for (String platform in globals.session?['preferences']['platforms']) {
      add(ViewingPlatformEvent(key: platform));
    }
  }

 /* void emitEvent(FormStatus status)
  {
    add(EmitEvent(status: status));
  }*/

  // movieCodes is dynamic because session['preferences']['moviesGenres'] is a List<dynamic>
  static List<String> movieCodesToGenres(final List<dynamic> movieCodes)
  {
    Map<int, String> genreByCode = MovieGenreList.map((key, value) => MapEntry(value, key));

    return movieCodes.map((code) => genreByCode[code] ?? 'Unknown').toList();
  }

  // bookCodes is dynamic because session['preferences']['literaryGenres'] is a List<dynamic>
  static List<String> bookCodesToGenres(final List<dynamic> bookCodes)
  {
    Map<String, String> genreByCode = bookGenreList.map((key, value) => MapEntry(value, key));

    return bookCodes.map((code) => genreByCode[code] ?? 'Unknown').toList();
  }

  /*void _interestChoices(InterestChoicesEvent interestChoices, Emitter<FormStates> emit) async
  {
    Map<String, bool> interestList = Map.from(state.interest);
    interestList[interestChoices.key] = !interestList[interestChoices.key]!;
    emit(state.copyWith(interest: interestList));
  }*/

  void _bookGenresEvent(BookGenresEvent bookGenresEvent, Emitter<FormStates> emit) async
  {
    Map<String, bool> listGenres = Map.from(state.bookGenres);
    listGenres[bookGenresEvent.key] = !listGenres[bookGenresEvent.key]!;
    emit(state.copyWith(bookGenres: listGenres));
  }

  void _movieGenresEvent(MovieGenresEvent movieGenresEvent, Emitter<FormStates> emit) async
  {
    Map<String, bool> movieList = Map.from(state.movieGenres);
    movieList[movieGenresEvent.key] = !movieList[movieGenresEvent.key]!;
    emit(state.copyWith(movieGenres: movieList));
  }

  void _viewingPlatformEvent(ViewingPlatformEvent viewingPlatformEvent, Emitter<FormStates> emit) async
  {
    Map<String, bool> viewingPlatformList = Map.from(state.viewingPlatform);
    viewingPlatformList[viewingPlatformEvent.key] = !viewingPlatformList[viewingPlatformEvent.key]!;
    emit(state.copyWith(viewingPlatform: viewingPlatformList));
  }
}
