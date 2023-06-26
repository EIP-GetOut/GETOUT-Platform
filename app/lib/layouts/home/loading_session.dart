/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/form/pages/social_media_spent_time.dart';
import 'package:getout/models/requests/get_session.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/layouts/home/load.dart';
import 'package:getout/layouts/connection/login.dart';

class LoadingPageSession extends StatefulWidget {
  const LoadingPageSession({Key? key}) : super(key: key);

  @override
  State<LoadingPageSession> createState() => _LoadingPageSessionState();
}

class _LoadingPageSessionState extends State<LoadingPageSession> {
  bool isLoading = true;
  bool session = false;

  getSession() async {
    SessionResponseInfo res = await RequestsService.instance.session();
    if (res.statusCode == 200) {
      session = true;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading && !session) {
      getSession();
      return const LoadPage();
    }
    if (!isLoading && !session) {
      return const ConnectionPage();
    }
    return const SocialMediaSpentTime();
  }
}