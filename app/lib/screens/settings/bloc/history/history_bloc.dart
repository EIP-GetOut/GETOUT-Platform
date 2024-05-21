/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getout/constants/http_status.dart';

import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/tools/status.dart';


part 'history_state.dart';
part 'history_event.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final SettingService service;

  HistoryBloc({
    required this.service,
  }) : super(const HistoryState()) {
    on<HistoryRequest>(_onHistoryRequest);
  }

  void _onHistoryRequest(
      HistoryRequest event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final recommendedBooks = await service.getHistoryBooks();
      final recommendedMovies = await service.getHistoryMovies();
      emit(
        state.copyWith(
          status: Status.success,
          recommendedBooks: recommendedBooks,
          recommendedMovies: recommendedMovies,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  /*@override
  RecommendedBooksState? fromJson(Map<String, dynamic> json) {
    return RecommendedBooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(RecommendedBooksState state) {
    return state.toMap();
  }*/
}
