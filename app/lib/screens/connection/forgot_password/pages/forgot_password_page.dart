/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:getout/screens/connection/forgot_password/children/check_email/pages/check_email_page.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/pages/new_password_page.dart';
import 'package:getout/screens/connection/services/service.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ConnectionService service;
  final TextEditingController email = TextEditingController();
  final TextEditingController code = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  ForgotPasswordPage({super.key, required this.service});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
/*            onPageChanged: (index) {
//              context.read<ForgotPasswordPageBloc>().add(ForgotPasswordPageToIdx(index));
            },*/
            children: <Widget>[
              CheckEmailPage(pageController: _pageController, email: email),
              NewPasswordPage(pageController: _pageController, password: password, confirmPassword: confirmPassword)
            ],
          ),
      );
  }
}
