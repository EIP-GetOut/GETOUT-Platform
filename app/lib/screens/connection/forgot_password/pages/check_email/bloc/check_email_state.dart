/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'check_email_bloc.dart';

class CheckEmailState extends Equatable {
  final String email;
  final Status status;
  final int? statusCode;
  bool get isEmailEmpty => email.isNotEmpty;

  const CheckEmailState({required this.email, this.status = Status.initial, this.statusCode});

  CheckEmailState copyWith({
    String? email,
    Status? status,
    int? statusCode
  }) {
    return CheckEmailState(
      email: email ?? this.email,
      status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode
    );
  }

  @override
  List<Object?> get props => [email, status, statusCode];
}
