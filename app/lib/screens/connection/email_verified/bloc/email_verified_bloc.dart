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

  EmailVerifiedBloc({required this.service})
      : super(const EmailVerifiedState()) {
    on<EmailVerifiedEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(
      EmailVerifiedEvent event, Emitter<EmailVerifiedState> emit) async {
    final EmailVerifiedResponseModel? emailVerifiedResponse;
    final EmailVerifiedResendResponseModel? evrResponse;

    if (event is EmailVerifiedCodeChanged) {
      emit(state.copyWith(code: event.code));
    } else if (event is EmailVerifiedResend) {

      if (service == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
        return;
      }
      evrResponse = await service?.emailVerifiedResend();
      if (evrResponse == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
      } else if (evrResponse.statusCode != EmailVerifiedResendResponseModel.success) {
        emit(state.copyWith(status: Status.error, statusCode: evrResponse.statusCode));
      } else {
        emit(state.copyWith(status: Status.success));
      }

    } else if (event is EmailVerifiedSubmitted) {
      emit(state.copyWith(status: Status.loading));
      if (service == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
        return;
      }
      emailVerifiedResponse = await service
          ?.emailVerified(EmailVerifiedRequestModel(code: state.code));
      if (emailVerifiedResponse == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
      } else if (emailVerifiedResponse.statusCode != EmailVerifiedResponseModel.success) {
        emit(state.copyWith(status: Status.error, statusCode: emailVerifiedResponse.statusCode));
      } else {
        emit(state.copyWith(status: Status.success));
      }
    }
  }
}