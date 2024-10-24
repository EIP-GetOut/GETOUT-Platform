/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:getout/tools/tools.dart';

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
        height: Tools.heightFactor(context, 0.06),
        color: (important == Important.important)
            ? const Color.fromRGBO(255, 82, 65, 0.4)
            : Colors.white,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
            child: Padding(padding: const EdgeInsets.only(right: 15.0, left: 15.0), child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (image != null) ? SvgPicture.asset(image!) : const SizedBox(),
                  SizedBox(width: Tools.widthFactor(context, 0.065)),
                  Text(value,
                      style: TextStyle(
                          fontSize:
                              (MediaQuery.of(context).size.width > 400)
                                  ? 18
                                  : 12,
                          color: (important == Important.warning)
                              ? Colors.red
                              : Colors.black87)),
                  const Expanded(child: SizedBox()),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ]))));
  }
}
