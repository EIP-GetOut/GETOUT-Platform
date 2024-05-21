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
import 'package:getout/screens/settings/bloc/history/history_bloc.dart';

part 'session.dart';
part 'history.dart';

class StatusResponse {
  const StatusResponse({this.status = HttpStatus.NOT_FOUND, this.error});

  final int status;
  final String? error;
}

class SettingService extends _SettingService<SessionService, HistoryService> {

  SettingService() {
    t = SessionService();
    g = HistoryService();
  }

  Future<StatusResponse> changeEmail(String password, String email) async =>
      t.changeEmail(password, email);

  Future<StatusResponse> changePassword(String password, String newPassword) async =>
      t.changePassword(password, newPassword);

  Future<StatusResponse> disconnect() async => t.disconnect();

  Future<StatusResponse> deleteAccount(String password) async =>
      t.deleteAccount(password);

  Future<StatusResponse> setLanguage(String language) async =>
      t.setLanguage(language);

  Future<StatusResponse> setTheme(String theme) async => t.setTheme(theme);

  Future<HistoryBooksResponse> getHistoryBooks() async => g.getHistoryBooks();
  Future<HistoryMoviesResponse> getHistoryMovies() async => g.getHistoryMovies();
}

abstract class ServiceTemplate {}

class _SettingService<T extends ServiceTemplate, G extends ServiceTemplate> {
  late final T t;
  late final G g;
}
