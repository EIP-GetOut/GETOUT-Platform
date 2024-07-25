/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'new_password_bloc.dart';

class NewPasswordRequestModel {
  const NewPasswordRequestModel({required this.code, required this.password,  required this.confirmPassword});

  final String code;
  final String password;
  final String confirmPassword;
}

class NewPasswordResponseModel {
  const NewPasswordResponseModel({required this.statusCode});

  static const int success = HttpStatus.OK;
  final int statusCode;
}


abstract class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();
}


class ForgotPasswordCodeChanged extends NewPasswordEvent {
  final String? code;

  const ForgotPasswordCodeChanged({this.code});

  @override
  List<Object?> get props => [code];
}

class ForgotPasswordPasswordChanged extends NewPasswordEvent {
  final String? password;

  const ForgotPasswordPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class ForgotPasswordConfirmPasswordChanged extends NewPasswordEvent {
  final String? confirmPassword;

  const ForgotPasswordConfirmPasswordChanged({this.confirmPassword});

  @override
  List<Object?> get props => [confirmPassword];
}

class ForgotPasswordSubmitted extends NewPasswordEvent {
  @override
  List<Object?> get props => [];
}
