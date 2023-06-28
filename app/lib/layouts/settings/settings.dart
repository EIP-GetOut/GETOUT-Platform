/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:getout/layouts/settings/edit_password.dart';
import 'package:flutter/material.dart';

class ParametersPage extends StatefulWidget {
  const ParametersPage({Key? key}) : super(key: key);

  @override
  State<ParametersPage> createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: const Text(
          'Paramètres',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            decorationThickness: 4,
            decorationColor: Color.fromRGBO(213, 86, 65, 0.992),
            decoration: TextDecoration.underline,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            const SizedBox(height: 40),
            const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text('Compte', style: TextStyle(fontSize: 22))
              ],
            ),
            const Divider(height: 20, thickness: 1),
            buildParameters(context, "Changer le Mot de Passe", const ParametersEditPasswordPage()),
//            startButton(context, MediaQuery.of(context).size.width),
          ])),
    );
  }

  GestureDetector buildParameters(BuildContext context, String title, StatefulWidget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => page));
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey)
            ],
          )),
    );
  }
}
