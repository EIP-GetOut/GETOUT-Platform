/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:bloc/bloc.dart';

import 'package:getout/bloc/user/user_data.dart';

/// Event being processed by [CounterBloc].
abstract class UserEvent {}

class UserSignIn extends UserEvent {}

class UserSignOut extends UserEvent {}

/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class UserBloc extends Bloc<UserEvent, UserData> {
  /// {@macro counter_bloc}
  UserBloc() : super(const UserData(isSigned: false)) {
    on<UserSignIn>((event, emit) => emit(const UserData(isSigned: true)));
    on<UserSignOut>((event, emit) => emit(const UserData(isSigned: false)));
  }
}