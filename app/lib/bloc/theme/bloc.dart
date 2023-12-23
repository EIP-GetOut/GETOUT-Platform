import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'default.dart';

@immutable
abstract class ThemeEvent {}

class ThemeToDefault extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  /// {@macro counter_bloc}
  ThemeBloc() : super(getOutTheme) {
    on<ThemeToDefault>((event, emit) => emit(getOutTheme));
  }
}