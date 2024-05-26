/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

class HistoryRow extends StatelessWidget {
  final String value;
  final bool background;
  final bool title;

  const HistoryRow(
      {super.key,
      required this.value,
      this.title = false,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.04,
        color: (title) ? Colors.black
                        : (background) ? const Color.fromARGB(255, 245, 245, 245)
                                        : Colors.white,
        child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,

                  child: Text(value,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize:
                              (MediaQuery.of(context).size.width > 400)
                                  ? 20
                                  : 12,
                          color: (!title) ? Colors.black87: Colors.white))),
                  //const Icon(Icons.arrow_forward_ios_rounded,
                  //    color: Colors.black54),
                ]));
  }
}
