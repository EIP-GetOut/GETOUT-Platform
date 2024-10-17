/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/tools/status.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final ConnectionService? service;

  NewPasswordBloc({required this.service}) : super(const NewPasswordState()) {
    on<NewPasswordEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(NewPasswordEvent event, Emitter<NewPasswordState> emit) async {
    final NewPasswordResponseModel? newPasswordResponse;

    if (event is ForgotPasswordCodeChanged) {
      emit(state.copyWith(code: event.code));
    } else if (event is ForgotPasswordPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is ForgotPasswordConfirmPasswordChanged) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    } else if (event is ForgotPasswordSubmitted) {
      emit(state.copyWith(status: Status.loading));
      if (service == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
        return;
      }
      newPasswordResponse = await service?.newPassword(NewPasswordRequestModel(
          code: state.code,
          password: state.password,
          confirmPassword: state.confirmPassword));
      if (newPasswordResponse == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
      } else if (newPasswordResponse.statusCode != NewPasswordResponseModel.success) {
        emit(state.copyWith(status: Status.error, statusCode: newPasswordResponse.statusCode));
      } else {
        emit(state.copyWith(status: Status.success));
      }
    }
  }
}
