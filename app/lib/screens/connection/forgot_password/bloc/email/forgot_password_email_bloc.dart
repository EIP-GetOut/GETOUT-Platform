/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/forgot_password/bloc/email/forgot_password_email_service.dart';
import 'package:getout/screens/connection/forgot_password/bloc/form_submit_status.dart';

part 'forgot_password_email_event.dart';
part 'forgot_password_email_state.dart';

class ForgotPasswordEmailBloc extends Bloc<ForgotPasswordEmailEvent, ForgotPasswordEmailState> {
  final ForgotPasswordEmailService? authRepo;

  ForgotPasswordEmailBloc({this.authRepo}) : super(const ForgotPasswordEmailState()) {
    on<ForgotPasswordEmailEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(ForgotPasswordEmailEvent event, Emitter<ForgotPasswordEmailState> emit) async
  {
    if (event is ForgotPasswordEmailChanged) {
      emit(state.copyWith(email: event.email));
    } else if (event is ForgotPasswordEmailSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo?.sendEmail(CheckEmailRequestModel(
          email: state.email,
        ));
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }
  }
}
