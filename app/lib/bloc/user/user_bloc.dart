/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:getout/bloc/user/user_service.dart';
import 'package:getout/screens/connection/services/service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';
part 'user_event.dart';

/// don't forget to call ..add.setup() when providing
class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(const UserState(cookiePath: '')) {
    on<SetupEvent>((event, emit) {
      //todo setup cookie
      setup(event, emit);
    });

    on<LoginEvent>((event, emit) async {
      await login(event, emit);
    });

    on<PreferenceEvent>((event, emit) {
      setPreference(event, emit);
    });

    on<DisconnectEvent>((event, emit) {
      disconnect(event, emit);
    });

    /*on<LoadingEvent>((event, emit) {
      loading(event, emit);
    });*/
  }

  //setup phone cookie
  void setup(SetupEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(cookiePath: '${event.dirPath}/.cookies/'));
  }

  Future login(LoginEvent event, Emitter<UserState> emit) async {
    try {
      print('0');
      Account? account = await UserService(state.cookiePath).getSession();
      print('1');
      if (account!.booksGenres.isEmpty ||
          account.moviesGenres.isEmpty ||
          account.platforms.isEmpty) {
        print('2.1');
        emit(state.copyWith(isCookieSet: true,
            account: account,
            status: Status.Login));
      } else {
        print('2.2');
        emit(state.copyWith(isCookieSet: true,
            account: account,
            status: Status.LoginWithPrefs));
      }
    } catch (e) {
      print('UserBloc<on>Login_catch $e');
      emit(state.copyWith(status: Status.Logout));
    }

  }

  void setPreference(PreferenceEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(
        account: state.account!.copyWith(
            platforms: event.platforms,
            booksGenres: event.bookGenres,
            moviesGenres: event.movieGenres),
        status: Status.LoginWithPrefs));
  }

  void disconnect(UserEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(status: Status.Logout));
  }

/*  void loading(LoadingEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(status: Status.Loading));
  }*/

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    // TODO: implement toJson
    return state.toJson();
  }
}
