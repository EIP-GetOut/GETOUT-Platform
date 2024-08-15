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
  final Object? exception;
  bool get isEmailEmpty => email.isNotEmpty;

  const CheckEmailState({required this.email, this.status = Status.initial, this.exception});

  CheckEmailState copyWith({
    String? email,
    Status? status,
    Object? exception
  }) {
    return CheckEmailState(
      email: email ?? this.email,
      status: status ?? this.status,
      exception: exception ?? this.exception
    );
  }

  @override
  List<Object?> get props => [email, status, exception];
}
