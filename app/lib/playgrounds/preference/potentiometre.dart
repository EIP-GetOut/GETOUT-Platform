/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  final double minTime = 0.0;
  final double maxTime = 12.0;
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double timeLost = 0;
  //int intTimeLost = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          const SizedBox(
              height: 110, child: Center(child: Text("-  -  -  -", style: TextStyle(color: Color(0xFF584CF4), fontSize: 50, fontWeight: FontWeight.bold)))),
          preferenceTitle(context, "Temps passé sur les réseaux sociaux par jour:"),
          SizedBox(
            height: 100,
            width: 350,
            child: preferenceTitle(context, '${timeLost.toInt()} H')
          ),
          SizedBox(
                  height: 60,
                  child: SliderTheme(
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
          ),
          SizedBox(
            width: 85 * MediaQuery.of(context).size.width / 100,
            child: Row(children: [
              slideLimitText(context, widget.minTime),
              SizedBox(width: 67 * MediaQuery.of(context).size.width / 100),
              slideLimitText(context, widget.maxTime)
            ])
          )
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

        //decoration: TextDecoration.underline,
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

        //decoration: TextDecoration.underline,
    ));
  }

}
