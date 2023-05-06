/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';


Future<String> login({required String email, required String password}) async
{
  final List<int> key = utf8.encode('keys');
  final List<int> bytes = utf8.encode(password);

  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(bytes);

  String cryptPassword = base64.encode(digest.bytes);

  return 'OK';
  /*var url = Uri.https(apiPath, signInPath);
  var body = jsonEncode({
    "username": email,
    "password": cryptPassword
  });

  try {
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json"
    });
    var data = jsonDecode(response.body);

    if (data['status'] == true) {
      myToken = data['token'];
      return data['token'];
    } else {
      return 'KO';
    }
  } catch (error) {
    if (error.toString() == 'Connection reset by peer' || error.toString() == 'Connection closed before full header was received') {
      return 'No internet connection';
    }
    return error.toString();
  }*/
}

Future<String> register(BuildContext context, {required String email, required String password}) async
{
  final List<int> key = utf8.encode('keys');
  final List<int> bytes = utf8.encode(password);

  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(bytes);

  String cryptPassword = base64.encode(digest.bytes);

  return 'OK';
  /*var url = Uri.https(apiPath, signUpPath);
  var body = jsonEncode({
    "username": email,
    "password": cryptPassword
  });

  try {
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json"
    });
    var data = jsonDecode(response.body);

    if (data['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
      return 'OK';
    } else {
      return 'KO';
    }
  } catch (error) {
    if (error.toString() == 'Connection reset by peer' || error.toString() == 'Connection closed before full header was received') {
      return 'No internet connection';
    }
    return error.toString();
  }*/
}