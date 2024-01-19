/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'forgot_password_page_bloc.dart';

class ForgotPasswordPageState extends Equatable {
  const ForgotPasswordPageState({
    this.idx = 0,
  });

  final int idx;

  ForgotPasswordPageState copyWith({
    int? idx,
  }) {
    return ForgotPasswordPageState(
      idx: idx ?? this.idx,
    );
  }

  @override
  List<Object> get props => [idx];
}