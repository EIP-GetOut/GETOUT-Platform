/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';

class GetSessionEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const GetSessionEvent();
}

class GetSessionRequest extends GetSessionEvent {
  const GetSessionRequest();
}

class GetSessionStatusResponse extends GetSessionEvent {
  const GetSessionStatusResponse(
      {this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.bornDate,
        this.createDate,
        this.preferences,
        required this.statusCode});

  bool get isSuccess => statusCode == HttpStatus.OK;

  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? bornDate;
  final String? createDate;
  final String? preferences;
  final int statusCode;
  static const int success = HttpStatus.OK;
}

class GetSessionPreview extends GetSessionEvent {
  const GetSessionPreview(
      {required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.bornDate,
        required this.createDate,
        required this.preferences});
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String bornDate;
  final String createDate;
  final String? preferences;
}