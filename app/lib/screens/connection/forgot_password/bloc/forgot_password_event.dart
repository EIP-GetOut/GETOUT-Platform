/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'forgot_password_bloc.dart';

class ForgotPasswordRequestModel {
  const ForgotPasswordRequestModel({required this.email});

  final String email;
}

class ForgotPasswordResponseModel {
  const ForgotPasswordResponseModel({required this.statusCode});

  static const int success = HttpStatus.OK;
  final int statusCode;
}


abstract class ForgotPasswordEvent extends Equatable {}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String? email;

  ForgotPasswordEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  @override
  List<Object?> get props => [];
}