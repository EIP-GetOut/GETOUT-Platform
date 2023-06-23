/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int divisions;
  final double initialValue;
  final ValueChanged<double> onChanged;

  const SliderWidget({super.key,
    this.minValue = 0.0,
    this.maxValue = 1.0,
    this.divisions = 10,
    this.initialValue = 0.0,
    required this.onChanged,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${_sliderValue.toInt()} H',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Slider(
          thumbColor: const Color.fromRGBO(213, 86, 65, 1),
          activeColor: Colors.black,
          secondaryActiveColor: const Color.fromRGBO(213, 86, 65, 1),
          inactiveColor: const Color.fromARGB(120, 213, 86, 65),
          value: _sliderValue,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: widget.divisions,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}