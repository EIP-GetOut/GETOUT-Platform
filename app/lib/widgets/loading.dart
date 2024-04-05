/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/tools/flex_size.dart';

//todo responsive
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLandscape = (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height);

    return Column(
      children: [
        SizedBox(height: perHeight(context, (isLandscape ? 25 : 30))),
        Row(children: [
          SizedBox(width: perWidth(context, (isLandscape ? 25 : 10))),
          SizedBox(
              height: uniHeight(context, 13, isLandscape),
              width: uniWidth(context, 27, isLandscape),
              child: Image.asset('assets/images/logo/getout.png')),
          SizedBox(width: perWidth(context, 4)),
          SizedBox(
              height: uniHeight(context, 10, isLandscape),
              width: uniWidth(context, 45, isLandscape),
              child: Image.asset('assets/images/other/text_getout.png'))
        ]),
        SizedBox(height: perHeight(context, (isLandscape ? 8 : 8))),
        const SizedBox(
          height: 85,
          width: 85,
          child: CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        )
      ],
    );
  }
}
