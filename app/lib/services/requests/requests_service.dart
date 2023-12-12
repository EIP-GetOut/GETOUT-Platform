/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import 'dart:convert';

import 'package:getout/models/connection/oauth.dart';
import 'package:getout/models/settings/edit_password.dart';
import 'package:http/http.dart' as http;

import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart' as api;

class RequestsService {
  RequestsService._();

  static final instance = RequestsService._();

  ///
  ///
  /// Tag: Settings - Edit Password
  /// Location: dashboard -> Settings -> Edit Password
  /// Description: This page allow you to change password from settings page
  ///
  ///
  Future<SettingsEditPasswordResponseInfo> settingsEditPassword(
      SettingsEditPasswordRequest request) async {
    final Uri url =
        Uri.http(api.rootApiPath, api.registerPath);
    final Map<String, String> header = {'Content-Type': 'application/json'};
    final String body = jsonEncode({
      'email': request.email,
      'password': request.password,
      'new_password': request.newPassword,
    });

    try {
      final http.Response response =
          await http.post(url, body: body, headers: header);
      if (response.statusCode != HttpStatus.OK) {
        return SettingsEditPasswordResponseInfo(
            statusCode: response.statusCode);
      }
      final dynamic data = jsonDecode(response.body);
      SettingsEditPasswordResponseInfo result =
          SettingsEditPasswordResponseInfo(
              id: data['id'],
              email: data['email'],
              password: data['password'],
              statusCode: response.statusCode);
      return result;
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return SettingsEditPasswordResponseInfo(
            statusCode: HttpStatus.NO_INTERNET);
      }
      return SettingsEditPasswordResponseInfo(statusCode: HttpStatus.APP_ERROR);
    }
  }

  ///
  ///
  /// Tag: Settings - Edit Password
  /// Location: dashboard -> Settings -> Edit Password
  /// Description: This page allow you to change password from settings page
  ///
  ///
  Future<OauthResponseInfo> oauth(OauthRequest request) async {
    final Uri url =
        Uri.http(api.rootApiPath, api.oauthPath);
    final Map<String, String> header = {'Content-Type': 'application/json'};
    final String body = jsonEncode({
      'email': request.email,
      'idToken': request.id,
    });

    try {
      final http.Response response =
          await http.post(url, body: body, headers: header);
      if (response.statusCode != HttpStatus.OK) {
        return OauthResponseInfo(statusCode: response.statusCode);
      }
      // final dynamic data = jsonDecode(response.body);
      OauthResponseInfo result =
          OauthResponseInfo(statusCode: response.statusCode);
      return result;
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return OauthResponseInfo(statusCode: HttpStatus.NO_INTERNET);
      }
      return OauthResponseInfo(statusCode: HttpStatus.APP_ERROR);
    }
  }
}
