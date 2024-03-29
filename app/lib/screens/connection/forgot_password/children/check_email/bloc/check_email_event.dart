/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'check_email_bloc.dart';

class CheckEmailRequestModel {
  const CheckEmailRequestModel({required this.email});

  final String email;
}

class CheckEmailResponseModel {
  const CheckEmailResponseModel({required this.statusCode});

  static const int success = HttpStatus.OK;
  final int statusCode;
}

abstract class CheckEmailEvent extends Equatable {}

class ForgotPasswordEmailChanged extends CheckEmailEvent {
  final String? email;

  ForgotPasswordEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class CheckEmailSubmitted extends CheckEmailEvent {
  @override
  List<Object?> get props => [];
}
