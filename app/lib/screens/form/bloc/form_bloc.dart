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
    List<bool> listGenres = List.from(state.literaryGenres);
    listGenres[literaryGenresEvent.index] = !listGenres[literaryGenresEvent.index];
        emit(state.copyWith(literaryGenres: listGenres));
  }

  void _interestChoices(InterestChoicesEvent interestChoices, Emitter<FormStates> emit) async
  {
    List<bool> interestList = List.from(state.interest);
    interestList[interestChoices.index] = !interestList[interestChoices.index];
    emit(state.copyWith(interest: interestList));
  }

  void _filmGenresEvent(FilmGenresEvent filmGenresEvent, Emitter<FormStates> emit) async
  {
    List<bool> filmList = List.from(state.filmGenres);
    filmList[filmGenresEvent.index] = !filmList[filmGenresEvent.index];
    emit(state.copyWith(filmGenres: filmList));
  }

  void _viewingPlatformEvent(ViewingPlatformEvent viewingPlatformEvent, Emitter<FormStates> emit) async
  {
    List<bool> viewingPlatformList = List.from(state.viewingPlatform);
    viewingPlatformList[viewingPlatformEvent.index] = !viewingPlatformList[viewingPlatformEvent.index];
    emit(state.copyWith(viewingPlatform: viewingPlatformList));
  }
}
