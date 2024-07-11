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

class SetupEvent extends UserEvent {
  final String dirPath;
  const SetupEvent({required this.dirPath});
}

class LoginEvent extends UserEvent {
  const LoginEvent();
}

class SessionEvent extends UserEvent {
  const SessionEvent();
}

class PreferenceEvent extends UserEvent {
  final List<int> movieGenres;
  final List<String> bookGenres;
  final List<String> platforms;

  const PreferenceEvent({required this.movieGenres, required this.bookGenres, required this.platforms});
}

class DisconnectEvent extends UserEvent {
  const DisconnectEvent();
}

class LoadingEvent extends UserEvent {
  const LoadingEvent();
}

