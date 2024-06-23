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

  FormEvent setKey(String key) {
    throw UnimplementedError('setKey() should be overridden in subclasses.');
  }
}

class EmitEvent extends FormEvent {
  final FormStatus status;

  const EmitEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

/*class SocialMediaTimeEvent extends FormEvent {
  final double? time;

  const SocialMediaTimeEvent({this.time});

  @override
  List<Object?> get props => [time];
}*/

/*class InterestChoicesEvent extends FormEvent {
  final String key;

  const InterestChoicesEvent({required this.key});

  @override
  List<Object?> get props => [key];
}*/

class LiteraryGenresEvent extends FormEvent {
  final String key;

  const LiteraryGenresEvent({required this.key});

  @override
  List<Object?> get props => [key];

  @override
  LiteraryGenresEvent setKey(String key) {
    return LiteraryGenresEvent(key: key);
  }
}

class FilmGenresEvent extends FormEvent {
  final String key;

  const FilmGenresEvent({required this.key});

  @override
  List<Object?> get props => [key];

  @override
  FilmGenresEvent setKey(String key) {
    return FilmGenresEvent(key: key);
  }
}

class ViewingPlatformEvent extends FormEvent {
  final String key;

  const ViewingPlatformEvent({required this.key});

  @override
  List<Object?> get props => [key];

  @override
  ViewingPlatformEvent setKey(String key) {
    return ViewingPlatformEvent(key: key);
  }
}

class EndFormEvent extends FormEvent {
  const EndFormEvent();

  @override
  List<Object?> get props => [];
}
