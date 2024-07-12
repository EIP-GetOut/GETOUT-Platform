/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_page_bloc.dart';
import 'package:getout/screens/connection/forgot_password/pages/check_email/pages/check_email_page.dart';
import 'package:getout/screens/connection/forgot_password/pages/new_password/pages/new_password_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordPageBloc, ForgotPasswordPageState>(builder: (context, state) {
      return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              context.read<ForgotPasswordPageBloc>().add(ForgotPasswordPageToIdx(index));
            },
            children: <Widget>[
              CheckEmailPage(pageController: _pageController),
              NewPasswordPage(pageController: _pageController)
            ],
          ),
      );
    });
  }
}
