/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/tools/tools.dart';

/// TODO responsive
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        SizedBox(height: Tools.heightFactor(context, 0.3)),
        Row(children: [
          SizedBox(width: Tools.widthFactor(context,0.1)),
          SizedBox(
              height: Tools.heightFactor(context, 0.13),
              width: Tools.widthFactor(context, 0.27),
              child: Image.asset('assets/images/logo/getout.png')),
          SizedBox(width: Tools.widthFactor(context, 0.04)),
          SizedBox(
              height: Tools.heightFactor(context, 0.1),
              width: Tools.widthFactor(context, 0.45),
              child: Image.asset('assets/images/other/text_getout.png'))
        ]),
        SizedBox(height: Tools.heightFactor(context, 0.08)),
        const SizedBox(
          height: 85,
          width: 85,
          child: CircularProgressIndicator(
            backgroundColor: Color.fromARGB(0, 255, 5, 5),
          ),
        )
      ],
    );
  }
}
