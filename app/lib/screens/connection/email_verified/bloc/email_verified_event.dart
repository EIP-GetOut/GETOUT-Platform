/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'email_verified_bloc.dart';

class EmailVerifiedRequestModel {
  const EmailVerifiedRequestModel({required this.code});

  final String code;
}

class EmailVerifiedResponseModel {
  const EmailVerifiedResponseModel({required this.statusCode});

  static const int success = HttpStatus.OK;
  final int statusCode;
}

abstract class EmailVerifiedEvent extends Equatable {
  const EmailVerifiedEvent();
}

class EmailVerifiedCodeChanged extends EmailVerifiedEvent {
  final String? code;

  const EmailVerifiedCodeChanged({this.code});

  @override
  List<Object?> get props => [code];
}

class EmailVerifiedSubmitted extends EmailVerifiedEvent {
  @override
  List<Object?> get props => [];
}

class EmailVerifiedResend extends EmailVerifiedEvent {
  @override
  List<Object?> get props => [];
}