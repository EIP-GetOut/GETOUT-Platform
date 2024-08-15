/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/tools/status.dart';

part 'edit_password_event.dart';
part 'edit_password_state.dart';

class EditPasswordBloc extends Bloc<EditPasswordEvent, EditPasswordState> {
  EditPasswordBloc() : super(const EditPasswordState())
  {
    on<EmitEvent>((event, emit) => emit(state.copyWith(status: event.status)));
    on<OldPasswordChanged>((event, emit) => emit(state.copyWith(oldPassword: event.oldPassword)));
    on<NewPasswordChanged>((event, emit) => emit(state.copyWith(newPassword: event.newPassword)));
    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
  }
}
