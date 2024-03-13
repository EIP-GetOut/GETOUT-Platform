/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String birthDate;
  final Status status;
  final Object? exception;
  bool get isEmailEmpty => email.isNotEmpty;
  // ignore: prefer_single_quotes
  bool get isEmailGood => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  bool get isEmailValid => isEmailEmpty && isEmailGood;
  bool get isFirstNameEmpty => firstName.isNotEmpty;
  bool get isLastNameEmpty => lastName.isNotEmpty;
  bool get isPasswordEmpty => password.isNotEmpty;
  bool get isPasswordLength => password.length >= 8;
  // ignore: prefer_single_quotes
  bool get isPasswordGood => RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$").hasMatch(password);
  bool get isPasswordValid => isPasswordEmpty && isPasswordLength && isPasswordGood;
  bool get isConfirmPasswordValid => password.isNotEmpty && (password == confirmPassword);


  const RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.birthDate = '',
    this.status = Status.initial,
    this.exception
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    String? birthDate,
    Status? status,
    Object? exception
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
      exception: exception ?? this.exception
    );
  }

  @override
  List<Object?> get props => [email, password, confirmPassword, firstName, lastName, birthDate, status, exception];
}
