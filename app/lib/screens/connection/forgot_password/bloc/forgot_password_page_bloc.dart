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

part 'forgot_password_page_event.dart';
part 'forgot_password_page_state.dart';

class ForgotPasswordPageBloc extends Bloc<ForgotPasswordPageEvent, ForgotPasswordPageState> {
  /// {@macro counter_bloc}
  ForgotPasswordPageBloc() : super(const ForgotPasswordPageState()) {
    on<ForgotPasswordPageToIdx>(_onForgotPasswordPageToIdx);
  }

  void _onForgotPasswordPageToIdx(ForgotPasswordPageToIdx event, Emitter<ForgotPasswordPageState> emit) {
    emit(state.copyWith(idx: event.idx));
  }
}