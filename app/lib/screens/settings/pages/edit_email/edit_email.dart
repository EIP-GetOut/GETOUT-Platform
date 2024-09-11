/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/pages/edit_email/new_email.dart';
import 'package:getout/screens/settings/pages/edit_email/email_verification.dart';
import 'package:getout/screens/settings/services/edit_email.dart';
import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/tools.dart';

class EditEmail extends StatelessWidget {
  const EditEmail({super.key});

  static const List<Widget> pages = [
    NewEmailPage(),
    EmailVerificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => EditEmailBloc(),
      child: BlocBuilder<EditEmailBloc, EditEmailStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            )
          ),
          body: Column(
            children: [
              PageTitle(
                  title: appL10n(context)!.change_email,
                  description: appL10n(context)!.change_email_label),
              SizedBox(height: Tools.heightFactor(context, 0.04)),
              SizedBox(
                width: Tools.widthFactor(context, 1),
                height: Tools.heightFactor(context, 0.70),
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages,
                ),
              ),
            ],
          ),
          floatingActionButton: _nextButton(pageController),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  Widget _nextButton(final PageController pageController) {

    return BlocBuilder<EditEmailBloc, EditEmailStates>(builder: (context, state) {
      // const CircularProgressIndicator()
      return DefaultButton(
          title: appL10n(context)!.confirm,
          onPressed: () {
            if (context.read<EditEmailBloc>().state.status
                  == EditEmailStatus.newEmail && context.read<EditEmailBloc>().state.isEverythingGood) {
              EditEmailServices().sendNewEmail(EditEmailRequestModel(email: context.read<EditEmailBloc>().state.newEmail, password: context.read<EditEmailBloc>().state.password))
                  .then((final EditEmailResponseModel value) {
                if (!value.isSuccessful && context.mounted) {
                  return showSnackBar(context, appL10n(context)!.error_unknown);
                }
                if (context.mounted) {
                  context
                      .read<EditEmailBloc>()
                      .add(const EmitEvent(status: EditEmailStatus.verificationEmail));
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                }
              });
            } else if (context.read<EditEmailBloc>().state.status ==
                EditEmailStatus.verificationEmail) {
              EditEmailServices().emailVerified(EmailVerificationRequestModel(code: context.read<EditEmailBloc>().state.code))
                  .then((final EmailVerificationResponseModel value) {
                      if (!value.isSuccessful && context.mounted) {
                        return showSnackBar(context, appL10n(context)!.error_unknown);
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
              });
            } else {
              /*if (context.mounted) {
                return showSnackBar(context, appL10n(context)!.error_unknown);
              }*/
            }
          });
    });
  }
}
