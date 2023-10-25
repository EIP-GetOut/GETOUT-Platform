/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;
  bool get isEmailEmpty => email.isNotEmpty;
  bool get isPasswordEmpty => password.isNotEmpty;

  const LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [email, password, formStatus];
}