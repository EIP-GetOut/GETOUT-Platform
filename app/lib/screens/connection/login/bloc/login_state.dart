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
  final Status status;
  final Object? exception;
  bool get isEmailEmpty => email.isNotEmpty;
  bool get isPasswordEmpty => password.isNotEmpty;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = Status.initial,
    this.exception,
  });

  LoginState copyWith({
    String? email,
    String? password,
    Status? status,
    Object? exception
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      exception: exception ?? this.exception
    );
  }

  @override
  List<Object?> get props => [email, password, status, exception];
}
