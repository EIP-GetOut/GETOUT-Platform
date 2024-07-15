import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/connection/email_verified/bloc/email_verified_bloc.dart';
import 'package:getout/screens/connection/email_verified/pages/email_verified_success_page.dart';
import 'package:getout/widgets/fields/code_field.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';

class EmailVerifiedPage extends StatelessWidget {
  EmailVerifiedPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<EmailVerifiedBloc, EmailVerifiedState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          showSnackBar(context, appL10n(context)!.error_unknown);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailVerifiedSuccessPage()));
        }
        if (state.status.isSuccess) {
          // Navigator.pop(context);
          // showSnackBar(context, appL10n(context)!.account_created,
          //     color: Colors.green);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmailVerifiedSuccessPage()));
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
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
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<EmailVerifiedBloc>()
                                .add(EmailVerifiedResend());
                            showSnackBar(
                                context,
                                appL10n(context)!
                                    .email_verification_resend_info,
                                color: Colors.green);
                          },
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
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color:
                                          Color.fromRGBO(213, 86, 65, 0.992)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ]),
          )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ConfirmCodeButton(formKey: _formKey)),
    ));
  }
}

class ConfirmCodeButton extends StatelessWidget {
  const ConfirmCodeButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailVerifiedBloc, EmailVerifiedState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : DefaultButton(
                title: appL10n(context)!.confirm,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<EmailVerifiedBloc>()
                        .add(EmailVerifiedSubmitted());
                  }
                });
      },
    );
  }
}
