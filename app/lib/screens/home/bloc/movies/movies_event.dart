/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';

class MoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const MoviesEvent();
}

class GenerateMoviesRequest extends MoviesEvent {
  const GenerateMoviesRequest();
}

class MovieStatusResponse extends MoviesEvent {
  const MovieStatusResponse(
      {this.id,
        this.title,
        this.posterPath,
        this.overview = 'Pas de description disponible',
        required this.statusCode});

  bool get isSuccess => statusCode == HttpStatus.OK;

  final int? id;
  final String? title;
  final String? posterPath;
  final String overview;
  final int statusCode;
  static const int success = HttpStatus.OK;
}

class MoviePreview extends MoviesEvent {
  const MoviePreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
}

typedef GenerateMoviesResponse = List<MoviePreview>;
