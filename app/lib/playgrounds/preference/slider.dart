/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

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

        ]));
  }

  Widget preferenceTitle(BuildContext context, String name) {
    return SizedBox(
        height: 100,
        width: 350,
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
    final double phoneHeight = MediaQuery.of(context).size.height;
    final double phoneWidth = MediaQuery.of(context).size.width;
    bool isLandscape = (phoneWidth > phoneHeight);

    return SizedBox(
        width: (isLandscape ? (95 * phoneWidth / 100) : (95 * phoneWidth / 100)),
        height: (isLandscape ? (10 * phoneHeight / 100) : (5 * phoneHeight / 100)),
        child: Row(children: [
          slideLimitText(context, widget.minTime),
          SizedBox(width: (isLandscape ? 82 : 75) * phoneWidth / 100),
          slideLimitText(context, widget.maxTime)
        ])
    );
  }

}
