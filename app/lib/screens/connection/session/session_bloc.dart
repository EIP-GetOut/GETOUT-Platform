/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/session/session_event.dart';
import 'package:getout/screens/connection/session/session_repository.dart';
import 'package:getout/tools/status.dart';

import 'package:getout/global.dart' as globals;

import 'package:equatable/equatable.dart';

part 'session_state.dart';

enum SessionStatus {
  notFound,
  found,
  error,
}

extension SessionStatusX on SessionStatus {
  bool get error => this == SessionStatus.error;
  bool get notFound => this == SessionStatus.notFound;
  bool get found => this == SessionStatus.found;
}

class SessionBloc extends Bloc<SessionEvent, SessionState> {

  SessionBloc({
    required this.sessionRepository
  }): super(const SessionState()) {
    on<SessionEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  final SessionRepository sessionRepository;


  Future mapEventToState(SessionEvent event, Emitter<SessionState> emit) async
  {
    emit(state.copyWith(status: Status.loading));
    try {
      final SessionStatusResponse sessionResponse = await globals.sessionManager.getSession();
      if (sessionResponse.statusCode == SessionStatus.found.index) {
        emit(state.copyWith(status: Status.is_found));
      } else if (sessionResponse.statusCode == SessionStatus.notFound.index){
        emit(state.copyWith(status: Status.is_not_found));
      }
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
