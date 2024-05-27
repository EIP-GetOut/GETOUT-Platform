/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/global.dart' as globals;

part 'edit_email_event.dart';
part 'edit_email_state.dart';

class EditEmailBloc extends Bloc<EditEmailEvent, EditEmailState> {
  EditEmailBloc() : super(const EditEmailState())
  {
    on<EmitEvent>((event, emit) => emit(state.copyWith(status: event.status)));
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<ConfirmEmailChanged>((event, emit) => emit(state.copyWith(confirmEmail: event.confirmEmail)));
  }
}
