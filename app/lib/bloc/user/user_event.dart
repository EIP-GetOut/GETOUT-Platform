/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'user_bloc.dart';

//Session
class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const UserEvent();
}

class SetupRequest extends UserEvent {
  const SetupRequest();
}

class LoginRequest extends UserEvent {
  final String email;
  final String password;

  const LoginRequest(this.email, this.password);
}

class SessionRequest extends UserEvent {
  const SessionRequest();
}

class DisconnectRequest extends UserEvent {
  const DisconnectRequest();
}