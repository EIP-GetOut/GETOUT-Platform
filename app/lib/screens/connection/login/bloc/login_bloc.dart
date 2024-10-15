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

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ConnectionService? service;

  LoginBloc({this.service}) : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(LoginEvent event, Emitter<LoginState> emit) async
  {
    final LoginResponseModel? loginResponse;

    if (event is LoginEmailChanged) {
      emit(state.copyWith(email: event.email));
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(status: Status.loading));

      loginResponse = await service?.login(LoginRequestModel(
        email: state.email,
        password: state.password,
      ));
      if (loginResponse == null) {
        emit(state.copyWith(status: Status.error, statusCode: HttpStatus.APP_ERROR));
      } else if (loginResponse.statusCode != LoginResponseModel.success) {
        emit(state.copyWith(status: Status.error, statusCode: loginResponse.statusCode));
      } else {
        emit(state.copyWith(status: Status.success));
      }
    }
  }
}
