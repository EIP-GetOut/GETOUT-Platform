/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import "package:flutter/material.dart";
import "package:getout/playground/playground.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Center(
        child: SizedBox(
          width: 300,
          height: 100,
          child: FloatingActionButton(
            shape: const RoundedRectangleBorder(),
              onPressed: () =>
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlaygroundPage())),
              child: const Text('Go to playground',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ))),
              )
          )
    );
  }
}
