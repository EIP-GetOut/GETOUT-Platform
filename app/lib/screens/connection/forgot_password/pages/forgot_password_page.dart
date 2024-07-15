/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/connection/forgot_password/children/check_email_page.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password_page.dart';
import 'package:getout/screens/connection/services/service.dart';

class ForgotPasswordPage extends StatelessWidget {
  final PageController _pageController = PageController();
  final TextEditingController email = TextEditingController();
  final TextEditingController code = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final ConnectionService service;

  ForgotPasswordPage({super.key, required this.service});


  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              CheckEmailPage(pageController: _pageController, email: email, service: service),
              NewPasswordPage(pageController: _pageController, email: email, code: code, password: password, confirmPassword: confirmPassword, service: service)
            ],
          ),
      );
  }
}
