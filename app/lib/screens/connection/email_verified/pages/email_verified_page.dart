import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/screens/connection/register/widgets/fields.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/code_field.dart';
import 'package:getout/widgets/fields/name_field.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/constants/http_status.dart';

class EmailVerifiedPage extends StatelessWidget {
  EmailVerifiedPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: /* BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isError) {
                if (state.exception is DioException &&
                    (state.exception as DioException).response != null &&
                    (state.exception as DioException).response!.statusCode ==
                        HttpStatus.CONFLICT) {
                  showSnackBar(context,
                      'Un compte avec cette adresse email existe déjà');
                } else {
                  showSnackBar(context, appL10n(context)!.error_unknown);
                }
              }
              if (state.status.isSuccess) {
                Navigator.pop(context);
                showSnackBar(context, appL10n(context)!.account_created,
                    color: Colors.green);
              }
            },
            child: */
            Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // title: Text(appL10n(context)!.your_profile),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageTitle(
                  title: appL10n(context)!.confirm_email_hint,
                  description: appL10n(context)!.email_verification_hint),
              const SizedBox(height: 30),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: EmailVerifiedCodeField()),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text.rich(
                  TextSpan(
                    text: "Vous n'avez rien reçue ? ",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                    children: <InlineSpan>[
                      TextSpan(
                        text: "Renvoyer l'email",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(213, 86, 65, 0.992)),
                      ),
                    ],
                  ),
                ),
              ),
                // const SizedBox(height: 30),
                // Align(
                //     alignment: Alignment.center,
                //     child: RegisterButton(formKey: _formKey)),
            ]),
      )),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ConfirmCodeButton(formKey: _formKey)),
    );
  }
}

class ConfirmCodeButton extends StatelessWidget {
  const ConfirmCodeButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisterState>(
    //   builder: (context, state) {
        /* return state.status.isLoading
            ? const CircularProgressIndicator()
            : */return DefaultButton(
                title: appL10n(context)!.confirm,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // context.read<RegisterBloc>().add(RegisterSubmitted());
                  }
                });
      // },
    // );
  }
}
