/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

/// Event being processed by [CounterBloc].
abstract class LocaleEvent {
}

/// Notifies bloc to increment state.
class LocaleToDefault extends LocaleEvent {
  final BuildContext context;

  LocaleToDefault({required this.context});
}

/// Notifies bloc to increment state.
class LocaleToFr extends LocaleEvent {}

/// Notifies bloc to increment state.
class LocaleToEn extends LocaleEvent {}

/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class LocaleBloc extends Bloc<LocaleEvent, Locale?> {
  /// {@macro counter_bloc}
  LocaleBloc(BuildContext context) : super(const Locale('fr')) {
    on<LocaleToDefault>((event, emit) => emit(Localizations.localeOf(event.context)));
    on<LocaleToFr>((event, emit) => emit(const Locale('fr')));
    on<LocaleToEn>((event, emit) => emit(const Locale('en')));
  }
}