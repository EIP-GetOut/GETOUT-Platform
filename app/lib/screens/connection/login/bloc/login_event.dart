/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'login_bloc.dart';

class LoginRequestModel {
  const LoginRequestModel({required this.email, required this.password});

  final String email;
  final String password;
}

class LoginResponseModel {
  const LoginResponseModel({required this.statusCode});

  static const int success = HttpStatus.OK;
  final int statusCode;
}


abstract class LoginEvent extends Equatable {}

class LoginEmailChanged extends LoginEvent {
  final String? email;

  LoginEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String? password;

  LoginPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  @override
  List<Object?> get props => [];
}