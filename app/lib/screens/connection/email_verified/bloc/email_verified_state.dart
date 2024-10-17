/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'email_verified_bloc.dart';

class EmailVerifiedState extends Equatable {
  final String code;
  final Status status;
  final int? statusCode;
  bool get isCodeValid => code.isNotEmpty;

  const EmailVerifiedState({
    this.code = '',
    this.status = Status.initial,
    this.statusCode
  });

  EmailVerifiedState copyWith({
    String? code,
    Status? status,
    int? statusCode
  }) {
    return EmailVerifiedState(
      code: code ?? this.code,
      status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode
    );
  }

  @override
  List<Object?> get props => [code, status, statusCode];
}