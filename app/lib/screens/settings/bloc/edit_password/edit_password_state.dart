/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'edit_password_bloc.dart';

class EditPasswordState extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final Status status;

  bool get isOldPasswordEmpty => oldPassword.isNotEmpty;
  bool get isNewPasswordEmpty => newPassword.isNotEmpty;
  bool get isPasswordValid => RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$').hasMatch(newPassword);
  bool get isNewPasswordGood => isNewPasswordEmpty && isPasswordValid;
  bool get isConfirmPasswordEmpty => confirmPassword.isNotEmpty;
  bool get isConfirmPasswordValid => confirmPassword == newPassword;
  bool get isConfirmPasswordGood => isConfirmPasswordEmpty && isConfirmPasswordValid;

  const EditPasswordState({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.status = Status.initial,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword, confirmPassword, status];

  EditPasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    Status? status,
  }) {
    return EditPasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }
}
