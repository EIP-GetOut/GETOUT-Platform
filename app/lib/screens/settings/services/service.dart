/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/global.dart' as globals;
import 'package:getout/tools/status.dart';

import '../../../constants/api_path.dart';

part 'session.dart';

class SettingService extends _SettingService<SessionService> {
  /*final String _id =
      (globals.session != null) ? globals.session!['id'].toString() : '';*/

  SettingService() {
    t = SessionService();
  }

  Future<StatusResponse> changeEmail(String password, String email) =>
      t.changeEmail(
          ChangeEmailRequest(password: password, newEmail: email));

  Future<StatusResponse> changePassword(String password, String newPassword) =>
      t.changePassword(
          ChangePasswordRequest(password: password, newPassword: newPassword));

  Future<StatusResponse> deleteAccount(String password) =>
      t.deleteAccount(DeleteAccountRequest(password: password));

  Future<StatusResponse> setLanguage(String language) =>
      t.setLanguage(SetLanguageRequest(lang: language));

  Future<StatusResponse> setTheme(String theme) =>
      t.setTheme(SetThemeRequest(theme: theme));
}

abstract class ServiceTemplate {}

class _SettingService<T extends ServiceTemplate> {
  late final T t;
}
