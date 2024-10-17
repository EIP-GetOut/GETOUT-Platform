/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'new_password_bloc.dart';

class NewPasswordState extends Equatable {
  final String code;
  final String password;
  final String confirmPassword;
  final Status status;
  final int? statusCode;
  bool get isPasswordEmpty => password.isNotEmpty;
  bool get isPasswordLength => password.length >= 8;
  // ignore: prefer_single_quotes
  bool get isPasswordGood => RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$").hasMatch(password);
  bool get isPasswordValid => isPasswordEmpty && isPasswordLength && isPasswordGood;
  bool get isConfirmPasswordValid => password.isNotEmpty && (password == confirmPassword);
  bool get isCodeValid => code.isNotEmpty;

  const NewPasswordState({
    this.code = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = Status.initial,
    this.statusCode
  });

  NewPasswordState copyWith({
    String? code,
    String? password,
    String? confirmPassword,
    Status? status,
    int? statusCode
  }) {
    return NewPasswordState(
      code: code ?? this.code,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode
    );
  }

  @override
  List<Object?> get props => [code, password, confirmPassword, status, statusCode];
}
