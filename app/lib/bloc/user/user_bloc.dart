/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:getout/bloc/user/user_service.dart';
import 'package:getout/screens/connection/services/service.dart';

part 'user_state.dart';
part 'user_event.dart';

/// don't forget to call ..add.setup() when providing
class UserBloc extends HydratedBloc<UserEvent, UserState> {

  UserBloc(): super(const UserState()) {

    on<SetupRequest>((event, emit) async { //todo setup cookie
      await setup(event, emit);
    });

    on<LoginRequest>((event, emit) async {
      await login(event, emit);
    });

    on<SessionRequest>((event, emit) async {
      await getSession(event, emit);
    });

    on<DisconnectRequest>((event, emit) async {
      await disconnect(event, emit);
    });

    if (state.cookiePath == null) {
      add(const SetupRequest());
    }
  }

  //setup phone cookie
  Future setup(UserEvent event, Emitter<UserState> emit) async {
    if (state.cookiePath == null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      emit(state.copyWith(cookiePath: '${appDocDir.path}/.cookies/'));
    }
  }

  Future login(LoginRequest event, Emitter<UserState> emit) async {
    final ConnectionService connectionService = ConnectionService(state.cookiePath!);

    connectionService.login(LoginRequestModel(email: event.email, password: event.password));
    emit(state.copyWith(isCookieSet: true));
  }

  //getSession
  Future getSession(UserEvent event, Emitter<UserState> emit) async {
    final UserService userService = UserService(state.cookiePath!);

    if (state.isCookieSet == false) {
      //final Dio dio = Dio()..interceptors.add(CookieManager(PersistCookieJar(ignoreExpires: true, storage: FileStorage(state.cookiePath))));

      emit(state.copyWith(account: await userService.getSession()));
    }
    //request for login and retrieve cookies.
    //set values
  }

  Future disconnect(UserEvent event, Emitter<UserState> emit) async {
    emit(const UserState());
  }

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