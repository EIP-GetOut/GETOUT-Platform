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
    // on<SocialMediaTimeEvent>((event, emit) => emit(state.copyWith(time: event.time)));
    // on<InterestChoicesEvent>(_interestChoices);
    on<LiteraryGenresEvent>(_literaryGenresEvent);
    on<FilmGenresEvent>(_filmGenresEvent);
    on<ViewingPlatformEvent>(_viewingPlatformEvent);
    on<EndFormEvent>((event, emit) => emit(state.copyWith()));
    on<ErrorEvent>((event, emit) => emit(state.copyWith()));
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
