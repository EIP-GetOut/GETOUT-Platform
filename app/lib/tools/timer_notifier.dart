/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'dart:async';

class TimerNotifier extends ChangeNotifier {
  late ValueNotifier<int> _timeNotifier;
  late int _initialTime;
  late Timer _timer;

  TimerNotifier(int initialTime) {
    _initialTime = initialTime;
    _timeNotifier = ValueNotifier<int>(_initialTime);
    _startTimer();
  }

  ValueNotifier<int> get timeNotifier => _timeNotifier;

  void _startTimer() {
    int elapsedTime = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime += 1;
      final remainingTime = _initialTime - elapsedTime;

      if (remainingTime <= 0) {
        _timeNotifier.value = 0;
        timer.cancel();
      } else {
        _timeNotifier.value = remainingTime;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timeNotifier.dispose();
    super.dispose();
  }
}
