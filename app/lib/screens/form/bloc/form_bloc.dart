/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStates> {
  FormBloc() : super(const FormStates())
  {
    on<EmitEvent>((event, emit) => emit(state.copyWith(status: event.status)));
    on<SocialMediaTimeEvent>((event, emit) => emit(state.copyWith(time: event.time)));
    on<InterestChoicesEvent>(_interestChoices);
    on<LiteraryGenresEvent>(_literaryGenresEvent);
    on<FilmGenresEvent>(_filmGenresEvent);
    on<ViewingPlatformEvent>(_viewingPlatformEvent);
    on<EndFormEvent>((event, emit) => emit(state.copyWith()));
  }

  void _literaryGenresEvent(LiteraryGenresEvent literaryGenresEvent, Emitter<FormStates> emit) async
  {
    List<bool> genreValues = state.literaryGenres.values.toList();
    genreValues[literaryGenresEvent.index] = !genreValues[literaryGenresEvent.index];
    final listGenres = Map.fromIterables(state.literaryGenres.keys, genreValues);
    emit(state.copyWith(literaryGenres: listGenres));
  }

  void _interestChoices(InterestChoicesEvent interestChoices, Emitter<FormStates> emit) async
  {
    List<bool> genreValues = state.interest.values.toList();
    genreValues[interestChoices.index] = !genreValues[interestChoices.index];
    final interestList = Map.fromIterables(state.interest.keys, genreValues);
    emit(state.copyWith(interest: interestList));
  }

  void _filmGenresEvent(FilmGenresEvent filmGenresEvent, Emitter<FormStates> emit) async
  {
    List<bool> genreValues = state.filmGenres.values.toList();
    genreValues[filmGenresEvent.index] = !genreValues[filmGenresEvent.index];
    final filmList = Map.fromIterables(state.filmGenres.keys, genreValues);
    emit(state.copyWith(filmGenres: filmList));
  }

  void _viewingPlatformEvent(ViewingPlatformEvent viewingPlatformEvent, Emitter<FormStates> emit) async
  {
    List<bool> genreValues = state.viewingPlatform.values.toList();
    genreValues[viewingPlatformEvent.index] = !genreValues[viewingPlatformEvent.index];
    final viewingPlatformList = Map.fromIterables(state.viewingPlatform.keys, genreValues);
    emit(state.copyWith(viewingPlatform: viewingPlatformList));
  }
}
