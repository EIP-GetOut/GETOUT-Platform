/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/tools/duration_format.dart';

import 'package:getout/tools/app_l10n.dart';

import 'package:provider/provider.dart';
import 'package:getout/tools/timer_notifier.dart';

// class RefreshTimeCard extends StatelessWidget {
//   const RefreshTimeCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TimerNotifier>(
//       builder: (context, timerNotifier, child) {
//         return Center(
//           child: Card.outlined(
//             shape: RoundedRectangleBorder(
//               side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 ListTile(
//                   leading: Icon(
//                     Icons.access_time_filled,
//                     color: Theme.of(context).primaryColor,
//                     size: 30,
//                   ),
//                   title: ValueListenableBuilder<int>(
//                     valueListenable: timerNotifier.timeNotifier,
//                     builder: (context, remainingSeconds, child) {
//                       return Text(
//                         durationFormatSeconds(
//                             appL10n(context)!.refresh, remainingSeconds),
//                         style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 18),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


class RefreshTimeCard extends StatelessWidget {
  const RefreshTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerNotifier>(
      builder: (context, timerNotifier, child) {
        return Center(
          child: Card.outlined(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Ajoute du padding autour du contenu
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adapte la taille de la colonne à son contenu
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      const SizedBox(width: 10), // Espace entre l'icône et le texte
                      Expanded( // Permet au texte d'occuper l'espace disponible
                        child: ValueListenableBuilder<int>(
                          valueListenable: timerNotifier.timeNotifier,
                          builder: (context, remainingSeconds, child) {
                            return Text(
                              durationFormatSeconds(
                                  appL10n(context)!.refresh, remainingSeconds),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
