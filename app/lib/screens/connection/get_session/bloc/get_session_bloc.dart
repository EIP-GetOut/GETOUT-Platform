/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/connection/get_session/bloc/get_session_event.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/screens/connection/get_session/bloc/get_session_service.dart';

part 'get_session_state.dart';

class GetSessionBloc extends Bloc<GetSessionEvent, GetSessionState> {
  final GetSessionService? service;

  GetSessionBloc({required this.service}) : super(const GetSessionState()) {
    on<GetSessionEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(GetSessionEvent event, Emitter<GetSessionState> emit) async
  {
    emit(state.copyWith(status: Status.loading));
    try {
      await service?.getSession(const GetSessionRequest());
      emit(state.copyWith(status: Status.success));
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }
}