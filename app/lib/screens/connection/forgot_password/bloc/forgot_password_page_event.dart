/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'forgot_password_page_bloc.dart';

abstract class ForgotPasswordPageEvent extends Equatable {
  const ForgotPasswordPageEvent();

  @override
  List<Object> get props => [];
}


class ForgotPasswordPageToIdx extends ForgotPasswordPageEvent {
  const ForgotPasswordPageToIdx(this.idx);

  final int idx;

  @override
  List<Object> get props => [idx];
}