/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:GetOut/models/flex_size.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage>
{
  @override
  Widget build(BuildContext context) {
    bool isLandscape = (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height);

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
