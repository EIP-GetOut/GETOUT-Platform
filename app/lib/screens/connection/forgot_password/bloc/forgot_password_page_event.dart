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