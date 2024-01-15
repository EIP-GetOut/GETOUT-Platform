/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
**
** example uses to do this: https://bloclibrary.dev/#/flutterlogintutorial
*/


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  /// {@macro counter_bloc}
  HomePageBloc() : super(const HomePageState()) {
    on<HomePageToIdx>(_onHomePageToIdx);
  }

  void _onHomePageToIdx(HomePageToIdx event, Emitter<HomePageState> emit) {
    emit(state.copyWith(idx: event.idx));
  }
}