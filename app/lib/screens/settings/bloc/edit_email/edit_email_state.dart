/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_email_bloc.dart';

enum EditEmailStatus {
  newEmail,
  newEmailSending,
  verificationEmail,
  verificationEmailSending,
  error
}

extension EditEmailStatusX on EditEmailStatus {
  bool get isNewEmail => this == EditEmailStatus.newEmail;
  bool get isNewEmailSending => this == EditEmailStatus.newEmailSending;
  bool get isCheckEmail => this == EditEmailStatus.verificationEmail;
  bool get isCheckEmailSending => this == EditEmailStatus.verificationEmailSending;
  bool get isError => this == EditEmailStatus.error;
}

class EditEmailStates extends Equatable {

  final EditEmailStatus status;
  final String newEmail;
  final String code;
  bool get isCodeValid => code.isNotEmpty;
  bool get isEmailEmpty => newEmail.isNotEmpty;
  bool get isEmailValid => RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(newEmail);
  bool get isNewEmailDifferent => newEmail != globals.session?['email'];
  bool get isEmailGood => isEmailEmpty && isEmailValid && isNewEmailDifferent;

  const EditEmailStates({
    this.status = EditEmailStatus.newEmail,
    this.newEmail = '',
    this.code = '',
  });

  @override
  List<Object?> get props =>
      [status, newEmail, code];

  EditEmailStates copyWith({
    EditEmailStatus? status,
    String? newEmail,
    String? code,
  }) {
    return EditEmailStates(
      status: status ?? this.status,
      newEmail: newEmail ?? this.newEmail,
      code: code ?? this.code,
    );
  }
}
