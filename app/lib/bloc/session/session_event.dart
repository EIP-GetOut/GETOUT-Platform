/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by InÃ¨s Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';

import 'package:getout/bloc/session/session_bloc.dart';

//Session
class SessionEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const SessionEvent();
}

class SessionRequest extends SessionEvent {
  const SessionRequest();
}

class DisconnectRequest extends SessionEvent {
  const DisconnectRequest();
}

class SessionStatusResponse extends SessionEvent {
  const SessionStatusResponse({required this.statusCode});

  bool get isSuccess => statusCode == SessionStatus.found.index;
  final int statusCode;
  static int success = SessionStatus.found.index;
}