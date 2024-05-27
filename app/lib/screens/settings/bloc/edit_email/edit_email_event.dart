/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_email_bloc.dart';

class EditEmailEvent extends Equatable {
  const EditEmailEvent();

  @override
  List<Object?> get props => [];
}

class EmitEvent extends EditEmailEvent {
  final Status status;

  const EmitEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

class EmailChanged extends EditEmailEvent {
  final String? email;

  const EmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends EditEmailEvent {
  final String? password;

  const PasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmEmailChanged extends EditEmailEvent {
  final String? confirmEmail;

  const ConfirmEmailChanged({this.confirmEmail});

  @override
  List<Object?> get props => [confirmEmail];
}