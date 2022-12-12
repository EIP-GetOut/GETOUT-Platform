/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

class GenerateMoviesRequest {
  String withGenres;
  bool includeAdult = true;

  GenerateMoviesRequest({
    required this.withGenres,
    this.includeAdult = false,
  });
}

class MoviePreview {
  int id;
  String title;
  String posterPath;

  MoviePreview(
      {required this.id, required this.title, required this.posterPath});
}

typedef GenerateMoviesResponse = List<MoviePreview>;
