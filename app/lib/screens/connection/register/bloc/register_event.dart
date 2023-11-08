/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'register_bloc.dart';

class RegisterRequestModel {
  const RegisterRequestModel({required this.email, required this.password, required this.firstName, required this.lastName, required this.bornDate});

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String bornDate;
}

class RegisterResponseModel {
  const RegisterResponseModel({required this.statusCode});

  static const int success = HttpStatus.CREATED;
  final int statusCode;
}


abstract class RegisterEvent extends Equatable {}

class RegisterEmailChanged extends RegisterEvent {
  final String? email;

  RegisterEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String? password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String? confirmPassword;

  RegisterConfirmPasswordChanged({this.confirmPassword});

  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterFirstNameChanged extends RegisterEvent {
  final String? firstName;

  RegisterFirstNameChanged({this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class RegisterLastNameChanged extends RegisterEvent {
  final String? lastName;

  RegisterLastNameChanged({this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class RegisterBornDateChanged extends RegisterEvent {
  final String? bornDate;

  RegisterBornDateChanged({this.bornDate});

  @override
  List<Object?> get props => [bornDate];
}

class RegisterSubmitted extends RegisterEvent {
  @override
  List<Object?> get props => [];
}