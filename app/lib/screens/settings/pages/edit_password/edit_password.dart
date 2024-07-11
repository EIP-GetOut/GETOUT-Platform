/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/edit_password/edit_password_bloc.dart';
import 'package:getout/screens/settings/services/edit_password.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/tools/tools.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/constants/http_status.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider<EditPasswordBloc>(
        create: (context) => EditPasswordBloc(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  PageTitle(
                      title: appL10n(context)!.change_password,
                      description: appL10n(context)!.change_password_label),
                  const SizedBox(height: 30),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditOldPasswordField()),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditNewPasswordField()),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditConfirmPasswordField()),
                ],
              ),
            ),
            floatingActionButton: SendNewNewButton(formKey: formKey),
          );
        }));
  }
}

class SendNewNewButton extends StatelessWidget {
  const SendNewNewButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
      builder: (context, state) {
        return (state.status == Status.loading)
            ? const CircularProgressIndicator()
            : SizedBox(
                width: Tools.widthFactor(context, 0.90),
                height: 65,
                child: DefaultButton(
                title: appL10n(context)!.edit_password,
                onPressed:  () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    String oldPassword =
                        context.read<EditPasswordBloc>().state.oldPassword;
                    String newPassword =
                        context.read<EditPasswordBloc>().state.newPassword;
                    EditPasswordServices()
                        .sendNewPassword(EditPasswordRequestModel(
                            oldPassword: oldPassword, newPassword: newPassword))
                        .then((final EditPasswordResponseModel value) {
                      if (value.statusCode == HttpStatus.UNAUTHORIZED) {
                        showSnackBar(context, appL10n(context)!.password_actual_error);
                      } else if (!value.isSuccessful) {
                        showSnackBar(context,
                            appL10n(context)!.error_unknown);
                      } else {
                        showSnackBar(
                            context, appL10n(context)!.password_edit_success,
                            color: Colors.green);
                      }
                    });
                  }));
      },
    );
  }
}
