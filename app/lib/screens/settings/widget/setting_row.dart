/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

enum Important {
  simple,
  warning,
  important,
}

class SettingRow extends StatelessWidget {
  final Widget page;
  final String? image;
  final String value;
  final Important? important;

  const SettingRow(
      {super.key,
      required this.page,
      required this.value,
      this.image,
      this.important = Important.simple});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.06,
        color: (important == Important.important)
            ? const Color.fromRGBO(255, 82, 65, 0.4)
            : Colors.white,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (image != null) ? SvgPicture.asset(image!) : const SizedBox(),
                  Text(value,
                      style: TextStyle(
                          fontSize:
                              (MediaQuery.of(context).size.width > 400)
                                  ? 20
                                  : 12,
                          color: (important == Important.warning)
                              ? Colors.red
                              : Colors.black87)),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ])));
  }
}
