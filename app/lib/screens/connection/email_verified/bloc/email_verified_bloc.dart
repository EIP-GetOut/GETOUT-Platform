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

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/tools/status.dart';

part 'email_verified_event.dart';
part 'email_verified_state.dart';

class EmailVerifiedBloc extends Bloc<EmailVerifiedEvent, EmailVerifiedState> {
  final ConnectionService? service;

  EmailVerifiedBloc({required this.service}) : super(const EmailVerifiedState()) {
    on<EmailVerifiedEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(EmailVerifiedEvent event, Emitter<EmailVerifiedState> emit) async {
    if (event is EmailVerifiedCodeChanged) {
      emit(state.copyWith(code: event.code));
    } else if (event is EmailVerifiedSubmitted) {
      emit(state.copyWith(status: Status.loading));

      try {
        await service?.emailVerified(
          EmailVerifiedRequestModel(
            code: state.code)
            );
        emit(state.copyWith(status: Status.success));
      } catch (e) {
        emit(state.copyWith(status: Status.error, exception: e));
      }
    }
  }
}
