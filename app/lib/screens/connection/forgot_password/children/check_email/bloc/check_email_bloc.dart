/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/screens/connection/services/service.dart';

part 'check_email_event.dart';
part 'check_email_state.dart';

class CheckEmailBloc extends Bloc<CheckEmailEvent, CheckEmailState> {
  final ConnectionService? service;

  CheckEmailBloc({required this.service}) : super(const CheckEmailState(email: '')) {
    on<CheckEmailEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(CheckEmailEvent event, Emitter<CheckEmailState> emit) async
  {
      if (event is ForgotPasswordEmailChanged) {
      emit(state.copyWith(email: event.email));
    } else if (event is CheckEmailSubmitted) {
      emit(state.copyWith(status: Status.loading));

      try {
        await service?.checkEmail(CheckEmailRequestModel(
          email: state.email,
        ));
        emit(state.copyWith(status: Status.success));
      } catch (e) {
        emit(state.copyWith(status: Status.error, exception: e));
      }
    }
  }
}
