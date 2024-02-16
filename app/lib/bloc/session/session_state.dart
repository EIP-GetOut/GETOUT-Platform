/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'session_bloc.dart';

class SessionState extends Equatable {
  const SessionState({
    this.status = Status.initial,
    SessionStatusResponse? sessionResponse
  }) : sessionResponse = sessionResponse ?? const SessionStatusResponse(statusCode : 200);

  final Status status;
  final SessionStatusResponse sessionResponse;

  @override
  List<Object?> get props => [status];

  SessionState copyWith({
    Status? status,
    SessionStatusResponse? sessionResponse,
  }) {
    return SessionState(
      status: status ?? this.status,
      sessionResponse : sessionResponse ?? this.sessionResponse,
    );
  }
}