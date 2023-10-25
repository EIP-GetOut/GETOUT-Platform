/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String email;
  final FormSubmissionStatus formStatus;
  bool get isEmailEmpty => email.isNotEmpty;

  const ForgotPasswordState({
    this.email = '',
    this.formStatus = const InitialFormStatus(),
  });

  ForgotPasswordState copyWith({
    String? email,
    FormSubmissionStatus? formStatus,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [email, formStatus];
}