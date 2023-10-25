/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_service.dart';

part 'form_submit_status.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordService? authRepo;

  ForgotPasswordBloc({this.authRepo}) : super(const ForgotPasswordState()) {
    on<ForgotPasswordEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(ForgotPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    if (event is ForgotPasswordEmailChanged) {
      emit(state.copyWith(email: event.email));
    } else if (event is ForgotPasswordSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo?.sendEmail(ForgotPasswordRequestModel(
          email: state.email,
        ));
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }
  }
}