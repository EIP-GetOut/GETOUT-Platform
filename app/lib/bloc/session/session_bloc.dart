/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/bloc/session/session_service.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/global.dart' as globals;

part 'session_state.dart';

enum SessionStatus {
  notFound,
  found,
  foundWithoutPreferences,
  error,
  emailNotVerified
}

extension SessionStatusX on SessionStatus {
  bool get error => this == SessionStatus.error;
  bool get notFound => this == SessionStatus.notFound;
  bool get found => this == SessionStatus.found;
  bool get foundWithoutPreferences => this == SessionStatus.foundWithoutPreferences;
  bool get emailNotVerified => this == SessionStatus.emailNotVerified;
}

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionService sessionService;

  SessionBloc({
    required this.sessionService
  }): super(const SessionState()) {
    on<SessionRequest>((event, emit) async {
      await login(event, emit);
    });
    on<DisconnectRequest>((event, emit) async {
      await disconnect(event, emit);
    });
  }

  Future login(SessionEvent event, Emitter<SessionState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final SessionStatusResponse sessionResponse = await globals.sessionManager.getSession();
      if (sessionResponse.statusCode == SessionStatus.found.index) {
        emit(state.copyWith(status: Status.isFound));
      } else if (sessionResponse.statusCode == SessionStatus.notFound.index) {
        emit(state.copyWith(status: Status.isNotFound));
      } else if (sessionResponse.statusCode == SessionStatus.foundWithoutPreferences.index) {
        emit(state.copyWith(status: Status.isFoundWithoutPreferences));
      } else if (sessionResponse.statusCode == SessionStatus.emailNotVerified.index) {
        emit(state.copyWith(status: Status.emailNotVerified));
      } else {
        emit(state.copyWith(status: Status.isNotFound));
      }
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future disconnect(SessionEvent event, Emitter<SessionState> emit) async {
    emit(state.copyWith(status: Status.isNotFound));
  }
}