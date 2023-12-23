import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

/// Event being processed by [CounterBloc].
abstract class LocaleEvent {
}

/// Notifies bloc to increment state.
class LocaleToDefault extends LocaleEvent {
  LocaleToDefault({required this.context});
  final BuildContext context;
}

/// Notifies bloc to increment state.
class LocaleToFr extends LocaleEvent {}

/// Notifies bloc to increment state.
class LocaleToEn extends LocaleEvent {}

/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  /// {@macro counter_bloc}
  LocaleBloc(BuildContext context) : super(Localizations.localeOf(context)) {
    on<LocaleToDefault>((event, emit) => emit(Localizations.localeOf(event.context)));
    on<LocaleToFr>((event, emit) => emit(const Locale('fr')));
    on<LocaleToEn>((event, emit) => emit(const Locale('en')));
  }
}