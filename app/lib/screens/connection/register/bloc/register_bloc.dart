/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/tools/status.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ConnectionService? service;

  RegisterBloc({this.service}) : super(const RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(RegisterEvent event, Emitter<RegisterState> emit) async
  {
    final RegisterResponseModel? registerResponse;

    if (event is RegisterEmailChanged) {
      emit(state.copyWith(email: event.email));
    } else if (event is RegisterPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is RegisterConfirmPasswordChanged) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    } else if (event is RegisterFirstNameChanged) {
      emit(state.copyWith(firstName: event.firstName));
    } else if (event is RegisterLastNameChanged) {
      emit(state.copyWith(lastName: event.lastName));
    } else if (event is RegisterBirthDateChanged) {
      emit(state.copyWith(birthDate: event.birthDate));
    } else if (event is RegisterSubmitted) {
      emit(state.copyWith(status: Status.loading));
      if (service == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
        return;
      }
      registerResponse = await service?.register(RegisterRequestModel(
        email: state.email,
        password: state.password,
        firstName: state.firstName,
        lastName: state.lastName,
        birthDate: state.birthDate,
      ));
      if (registerResponse == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
      } else if (registerResponse.statusCode != RegisterResponseModel.success) {
        emit(state.copyWith(status: Status.error, statusCode: registerResponse.statusCode));
      } else {
        emit(state.copyWith(status: Status.success));
      }
    }
  }
}
