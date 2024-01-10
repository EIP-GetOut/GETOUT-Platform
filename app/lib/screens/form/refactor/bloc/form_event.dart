/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_bloc.dart';

class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object?> get props => [];
}

class EmitEvent extends FormEvent {
  final FormStatus status;

  const EmitEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

class SocialMediaTimeEvent extends FormEvent {
  final double? time;

  const SocialMediaTimeEvent({this.time});

  @override
  List<Object?> get props => [time];
}

class InterestChoicesEvent extends FormEvent {
  final int index;

  const InterestChoicesEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class LiteraryGenresEvent extends FormEvent {
  final int index;

  const LiteraryGenresEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class FilmGenresEvent extends FormEvent {
  final int index;

  const FilmGenresEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class ViewingPlatformEvent extends FormEvent {
  final int index;

  const ViewingPlatformEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EndFormEvent extends FormEvent {
  const EndFormEvent();

  @override
  List<Object?> get props => [];
}