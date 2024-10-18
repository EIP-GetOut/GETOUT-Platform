/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/global.dart' as globals;
import 'package:getout/tools/duration_format.dart';

import 'package:getout/tools/app_l10n.dart';

import 'package:provider/provider.dart';
import 'dart:math';
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

class RefreshTimeCard extends StatelessWidget {
  const RefreshTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final int initialTime = min(
      globals.session?['secondsBeforeNextMovieRecommendation'] ?? 0,
      globals.session?['secondsBeforeNextBookRecommendation'] ?? 0
    );

    return ChangeNotifierProvider(
      create: (_) => TimerNotifier(initialTime),
      child: Consumer<TimerNotifier>(
        builder: (context, timerNotifier, child) {
          return Center(
            child: Card.outlined(
              color: Colors.black26,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.access_time_filled,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: ValueListenableBuilder<int>(
                      valueListenable: timerNotifier.timeNotifier,
                      builder: (context, remainingSeconds, child) {
                        return Text(
                          durationFormatSeconds(
                              appL10n(context)!.refresh, remainingSeconds),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
