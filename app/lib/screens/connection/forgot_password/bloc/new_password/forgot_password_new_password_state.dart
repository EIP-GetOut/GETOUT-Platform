/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'forgot_password_new_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String code;
  final String password;
  final String confirmPassword;
  final FormSubmissionStatus formStatus;
  bool get isPasswordEmpty => password.isNotEmpty;
  bool get isPasswordLength => password.length >= 8;
  // ignore: prefer_single_quotes
  bool get isPasswordGood => RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$").hasMatch(password);
  bool get isPasswordValid => isPasswordEmpty && isPasswordLength && isPasswordGood;
  bool get isConfirmPasswordValid => password.isNotEmpty && (password == confirmPassword);
  bool get isCodeValid => code.isNotEmpty && true;// code.length == 6;

  const ForgotPasswordState({
    this.code = '',
    this.password = '',
    this.confirmPassword = '',
    this.formStatus = const InitialFormStatus(),
  });

  ForgotPasswordState copyWith({
    String? code,
    String? password,
    String? confirmPassword,
    FormSubmissionStatus? formStatus,
  }) {
    return ForgotPasswordState(
      code: code ?? this.code,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [code, password, confirmPassword, formStatus];
}