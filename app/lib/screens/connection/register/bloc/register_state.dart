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
  final String bornDate;
  final FormSubmissionStatus formStatus;
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
    this.bornDate = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    String? bornDate,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bornDate: bornDate ?? this.bornDate,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [email, password, confirmPassword, firstName, lastName, bornDate, formStatus];
}