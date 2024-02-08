/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'get_session_bloc.dart';

class GetSessionState extends Equatable {
  const GetSessionState({
    this.status = Status.initial,
    GetSessionPreview? session,
  }) : session = session ?? const GetSessionPreview(bornDate: '', id: '', email: '', lastName: '', firstName: '', createDate: '', preferences: '');

  final GetSessionPreview session;
  final Status status;

  @override
  List<Object?> get props => [status, session];

  GetSessionState copyWith({
    GetSessionPreview? session,
    Status? status,
  }) {
    return GetSessionState(
      session: session ?? this.session,
      status: status ?? this.status,
    );
  }
}