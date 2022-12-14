/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import "package:flutter/material.dart";

class CoverPage extends StatefulWidget {
  const CoverPage({Key? key}) : super(key: key);

  @override
  State<CoverPage> createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
              height: 300,
              width: 300,
              child: const DecoratedBox(
                decoration: const BoxDecoration(
                    color: Colors.greenAccent
                ),
              )
            ),
    );
  }
}
