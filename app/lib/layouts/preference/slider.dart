/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/models/flex_size.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key, required this.title, required this.minTime, required this.maxTime}) : super(key: key);

  final String title;
  final double minTime;
  final double maxTime;
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double timeLost = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          preferenceTitle(context, widget.title),
          SizedBox(
            height: 50,
            child: preferenceTitle(context, '${timeLost.toInt()}H')
          ),
          SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTickMarkColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent
                    ),
                    child: Slider(
                      min: widget.minTime,
                      max: widget.maxTime,
                      divisions: 10,
                      value: timeLost,
                      label: '${timeLost.toInt()}H',
                      onChanged: (value) {
                        setState(() {
                          timeLost = value;
                        });
                      })),
          printLimit(context)
        ]));
  }

  Widget preferenceTitle(BuildContext context, String name) {
    return SizedBox(
        height: perHeight(context, 13),
        width: perWidth(context, 95),
        child: Text(
      name,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  Widget slideLimitText(BuildContext context, double limit) {
    return Text(
        '${limit.toInt()}H',
        textAlign: TextAlign.center,
        style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
    ));
  }

  Widget printLimit(BuildContext context) {
    bool isLandscape = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height);

    return SizedBox(
        width: perWidth(context, 95),
        height: perHeight(context, (isLandscape ? 10 : 5)),
        child: Row(children: [
          slideLimitText(context, widget.minTime),
          SizedBox(width: perWidth(context, isLandscape ? 82 : 75)),
          slideLimitText(context, widget.maxTime)
        ])
    );
  }

}
