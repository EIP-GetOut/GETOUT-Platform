/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

class GenerateMoviesRequest {
  List<int> genres;
  bool includeAdult = true;

  GenerateMoviesRequest({
    required this.genres,
    this.includeAdult = false,
  });
}

class MoviePreview {
  int id;
  String title;
  String? posterPath;
  String? overview;

  MoviePreview(
      {required this.id, required this.title, required this.posterPath, required this.overview});
}

typedef GenerateMoviesResponse = List<MoviePreview>;
