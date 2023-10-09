/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/tools/flex_size.dart';
import 'package:getout/screens/form/pages/social_media_spent_time.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    bool isLandscape = (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          leading: const BackButton(),
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                SizedBox(width: perWidth(context, (isLandscape ? 28 : 16))),
                SizedBox(
                    height: uniHeight(context, 13, isLandscape),
                    width: uniWidth(context, 27, isLandscape),
                    child: Image.asset('assets/GetOut_logo.png')),
                SizedBox(width: perWidth(context, 4)),
                const Text('GETOUT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
              ])),
          SizedBox(
            height: perHeight(context, (isLandscape ? 40 : 50)),
            width: perWidth(context, (isLandscape ? 40 : 100)),
            child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/welcome_img.png')),
          ),
          SizedBox(
              height: perHeight(context, 15),
              width: perWidth(context, 95),
              child: const Text(
                  'Devenez plus productif en réduisant le temps passé sur les réseaux sociaux',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            startButton(context, MediaQuery.of(context).size.width));
  }

  Widget startButton(BuildContext context, double phoneWidth) {
    return SizedBox(
        width: 85 * phoneWidth / 100,
        height: 65,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color(0xFF584CF4),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SocialMediaSpentTime())),
            child: const Text('Commencer l\'aventure',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }
}