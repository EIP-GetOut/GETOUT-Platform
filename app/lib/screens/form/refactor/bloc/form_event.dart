/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_bloc.dart';

class FormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFormEvent extends FormEvent {
  @override
  List<Object?> get props => [];
}
class EmitEvent extends FormEvent {
  final FormStatus status;

  EmitEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

class SocialMediaTimeEvent extends FormEvent {
  final double? time;

  SocialMediaTimeEvent({this.time});

  @override
  List<Object?> get props => [time];
}

class InterestChoicesEvent extends FormEvent {
  final int index;

  InterestChoicesEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class LiteraryGenresEvent extends FormEvent {
  final int index;

  LiteraryGenresEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class FilmGenresEvent extends FormEvent {
  final int index;

  FilmGenresEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class ViewingPlatformEvent extends FormEvent {
  final int index;

  ViewingPlatformEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EndFormEvent extends FormEvent {
  @override
  List<Object?> get props => [];
}