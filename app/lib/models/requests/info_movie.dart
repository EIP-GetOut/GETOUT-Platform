/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class CreateInfoMovieRequest {
  final int id;

  CreateInfoMovieRequest({
    required this.id
  });
}

class InfoMovieResponse
{
  static const int success = HttpStatus.OK;
  String? title;
  String? overview;
  String? posterPath;
  String? backdropPath;
  String? releaseDate;
  double? voteAverage;
  String? duration;
  int statusCode;

  InfoMovieResponse({
    this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.duration,
    required this.statusCode
  });
}
