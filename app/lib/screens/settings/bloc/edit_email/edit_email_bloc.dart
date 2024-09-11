/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/global.dart' as globals;

part 'edit_email_event.dart';
part 'edit_email_state.dart';

class EditEmailBloc extends Bloc<EditEmailEvent, EditEmailStates> {
  EditEmailBloc() : super(const EditEmailStates())
  {
    on<EmitEvent>((event, emit) => emit(state.copyWith(status: event.status)));
    on<NewEmailEvent>((event, emit) => emit(state.copyWith(newEmail: event.newEmail, password: event.password, confirmEmail: event.confirmEmail)));
    on<VerificationEmailEvent>((event, emit) => emit(state.copyWith(code: event.code)));
    on<ErrorEvent>((event, emit) => emit(state.copyWith()));
  }
}
