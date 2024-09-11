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
  final EditEmailStatus status;

  const EmitEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

class NewEmailEvent extends EditEmailEvent {
  final String newEmail;
  final String confirmEmail;
  final String password;

  const NewEmailEvent({required this.newEmail, required this.confirmEmail, required this.password});

  @override
  List<Object?> get props => [newEmail, confirmEmail, password];
}

class VerificationEmailEvent extends EditEmailEvent {
  final String code;

  const VerificationEmailEvent({required this.code});

  @override
  List<Object?> get props => [code];
}

class ErrorEvent extends EditEmailEvent {
  const ErrorEvent();

  @override
  List<Object?> get props => [];
}