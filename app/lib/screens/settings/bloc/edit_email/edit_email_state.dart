/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_email_bloc.dart';

class EditEmailState extends Equatable {
  final String email;
  final String confirmEmail;
  final String password;
  final Status status;

  bool get isEmailEmpty => email.isNotEmpty;
  bool get isEmailValid => RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  bool get isNewEmailDifferent => email != globals.session?['email'];
  bool get isEmailGood => isEmailEmpty && isEmailValid && isNewEmailDifferent;
  bool get isPasswordEmpty => password.isNotEmpty;
  bool get isConfirmEmailEmpty => confirmEmail.isNotEmpty;
  bool get isConfirmEmailValid => confirmEmail == email;
  bool get isConfirmEmailGood => isConfirmEmailEmpty && isConfirmEmailValid;

  const EditEmailState({
    this.email = '',
    this.confirmEmail = '',
    this.password = '',
    this.status = Status.initial,
  });

  @override
  List<Object?> get props => [email, confirmEmail, password, status];

  EditEmailState copyWith({
    String? email,
    String? confirmEmail,
    String? password,
    Status? status,
  }) {
    return EditEmailState(
      email: email ?? this.email,
      confirmEmail: confirmEmail ?? this.confirmEmail,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
