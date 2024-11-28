/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/global.dart' as globals;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getout/global.dart' as globals;
import 'dart:async';
import 'dart:math'; // Pour min<int>
import 'dart:io';

class TimerNotifier extends ChangeNotifier {
  late ValueNotifier<int> _timeNotifier;
  late int _initialTime;
  Timer? _timer;

  TimerNotifier(int initialTime) {
    _initialTime = initialTime;
    _timeNotifier = ValueNotifier<int>(_initialTime);
    _startTimer();
  }

  ValueNotifier<int> get timeNotifier => _timeNotifier;

  void _startTimer() {
    _timer?.cancel(); // Annule le timer s'il existe déjà
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

  Future<void> restartTimerIfZero() async {
    print(globals.session);
    if (_timeNotifier.value == 0) {
      // sleep(const Duration(seconds: 5));
      print('value == 0');
      await globals.sessionManager.getSession(); // Récupère la session mise à jour

      // Calcule la nouvelle valeur minimale
      int newInitialTime = min<int>(
        globals.session?['secondsBeforeNextMovieRecommendation'] ?? 0,
        globals.session?['secondsBeforeNextBookRecommendation'] ?? 0,
      );
      
      // newInitialTime += 30;
      // Mets à jour _initialTime et redémarre le timer
      _initialTime = newInitialTime;
      _timeNotifier.value = _initialTime; // Mets aussi à jour l'affichage
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timeNotifier.dispose();
    super.dispose();
  }
}
