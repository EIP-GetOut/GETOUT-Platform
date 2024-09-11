/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:getout/widgets/fields/code_field.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> enabledResend = ValueNotifier<bool>(true);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: EmailVerificationCodeField()),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: enabledResend,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: value
                              ? () {
                                  enabledResend.value = false;
                                  Timer(const Duration(seconds: 10), () {
                                    enabledResend.value = true;
                                  });
                                  /*context
                                      .read<EditEmailBloc>()
                                      .add(EmailVerifiedResend());*/
                                  showSnackBar(
                                      context,
                                      appL10n(context)!
                                          .email_verification_resend_info,
                                      color: Colors.green);
                                }
                              : null,
                          child: Text.rich(
                            TextSpan(
                              text: appL10n(context)!
                                  .email_verification_resend_hint,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: appL10n(context)!
                                      .email_verification_resend,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: value
                                          ? const Color.fromRGBO(
                                              213, 86, 65, 0.992)
                                          : Colors.black.withOpacity(0.25)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ]),
      )),
    );
  }
}
