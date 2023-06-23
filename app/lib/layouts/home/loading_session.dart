/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/layouts/home/dashboard.dart';
import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/models/requests/get_session.dart';
import 'package:getout/models/flex_size.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/layouts/home/loading.dart';
import 'package:getout/layouts/connection/login.dart';

import 'dart:math';

import 'package:http_status_code/http_status_code.dart';

class LoadingPageSession extends StatefulWidget {
  const LoadingPageSession({Key? key}) : super(key: key);

  @override
  State<LoadingPageSession> createState() => _LoadingPageSessionState();
}

class _LoadingPageSessionState extends State<LoadingPageSession> {
  @override
  Widget build(BuildContext context) {
    bool isLandscape = (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RequestsService.instance
          .session()
          .then((SessionResponseInfo sessionResponse) {
            print(sessionResponse.cookie);
            if (sessionResponse.statusCode == 200) {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoadingPage()));
            } else {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ConnectionPage()));
            }});
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: Column(children: [
            SizedBox(height: perHeight(context, (isLandscape ? 25 : 30))),
            Row(children: [
              SizedBox(width: perWidth(context, (isLandscape ? 25 : 10))),
              SizedBox(
                  height: uniHeight(context, 13, isLandscape),
                  width: uniWidth(context, 27, isLandscape),
                  child: Image.asset('assets/GetOut_logo.png')),
              SizedBox(width: perWidth(context, 4)),
              SizedBox(
                  height: uniHeight(context, 10, isLandscape),
                  width: uniWidth(context, 45, isLandscape),
                  child: Image.asset('assets/GetOut_text.png'))
            ]),
            SizedBox(height: perHeight(context, (isLandscape ? 8 : 8))),
            const SizedBox(
              height: 85,
              width: 85,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            )
          ]),
        ));
  }
}