/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/bloc/user/user_bloc.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final Account? account = context.watch<UserBloc>().state.account;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.15,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //icons with color ?
            Icon(Icons.face, size: MediaQuery.of(context).size.height * 0.12),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${account?.firstName} ${account?.lastName}'.toLowerCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width > 400)
                              ? 30
                              : 16,
                          color: Colors.black87)),
                  Text('${account?.email}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width > 400)
                              ? 20
                              : 12,
                          color: Colors.black87)),
                ]),
        ]));
  }
}
