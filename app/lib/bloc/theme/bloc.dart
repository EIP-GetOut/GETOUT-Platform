/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

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