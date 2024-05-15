/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart' as globals;
import 'package:getout/constants/api_path.dart';

part 'session.dart';

class SettingService extends _SettingService<SessionService> {
  /*final String _id =
      (globals.session != null) ? globals.session!['id'].toString() : '';*/

  SettingService() {
    t = SessionService();
  }

  Future<StatusResponse> changeEmail(String password, String email) async =>
      t.changeEmail(password, email);

  Future<StatusResponse> changePassword(String password, String newPassword) async =>
      t.changePassword(password, newPassword);

  Future<StatusResponse> disconnect() async => t.disconnect();

  Future<StatusResponse> deleteAccount() async =>
      t.deleteAccount();

  Future<StatusResponse> setLanguage(String language) async =>
      t.setLanguage(language);

  Future<StatusResponse> setTheme(String theme) async => t.setTheme(theme);
}

abstract class ServiceTemplate {}

class _SettingService<T extends ServiceTemplate> {
  late final T t;
}
