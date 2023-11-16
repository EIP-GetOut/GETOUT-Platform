/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'forgot_password_new_password_bloc.dart';

class NewPasswordRequestModel {
  const NewPasswordRequestModel({required this.code, required this.password});

  final String code;
  final String password;
}

class NewPasswordResponseModel {
  const NewPasswordResponseModel({required this.statusCode});

  static const int success = HttpStatus.OK;
  final int statusCode;
}


abstract class ForgotPasswordEvent extends Equatable {}


class ForgotPasswordCodeChanged extends ForgotPasswordEvent {
  final String? code;

  ForgotPasswordCodeChanged({this.code});

  @override
  List<Object?> get props => [code];
}

class ForgotPasswordPasswordChanged extends ForgotPasswordEvent {
  final String? password;

  ForgotPasswordPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class ForgotPasswordConfirmPasswordChanged extends ForgotPasswordEvent {
  final String? confirmPassword;

  ForgotPasswordConfirmPasswordChanged({this.confirmPassword});

  @override
  List<Object?> get props => [confirmPassword];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  @override
  List<Object?> get props => [];
}