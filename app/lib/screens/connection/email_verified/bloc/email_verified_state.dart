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
  final Object? exception;
  bool get isCodeValid => code.isNotEmpty && true;// code.length == 6;

  const EmailVerifiedState({
    this.code = '',
    this.status = Status.initial,
    this.exception
  });

  EmailVerifiedState copyWith({
    String? code,
    Status? status,
    Object? exception
  }) {
    return EmailVerifiedState(
      code: code ?? this.code,
      status: status ?? this.status,
      exception: exception ?? this.exception
    );
  }

  @override
  List<Object?> get props => [code, status, exception];
}