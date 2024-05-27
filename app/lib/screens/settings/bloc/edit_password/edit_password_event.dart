/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_password_bloc.dart';

class EditPasswordEvent extends Equatable {
  const EditPasswordEvent();

  @override
  List<Object?> get props => [];
}

class EmitEvent extends EditPasswordEvent {
  final Status status;

  const EmitEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

class OldPasswordChanged extends EditPasswordEvent {
  final String? oldPassword;

  const OldPasswordChanged({this.oldPassword});

  @override
  List<Object?> get props => [oldPassword];
}

class NewPasswordChanged extends EditPasswordEvent {
  final String? newPassword;

  const NewPasswordChanged({this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}

class ConfirmPasswordChanged extends EditPasswordEvent {
  final String? confirmPassword;

  const ConfirmPasswordChanged({this.confirmPassword});

  @override
  List<Object?> get props => [confirmPassword];
}