/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_service.dart';

class FormRequestModel {
  final List<int> movieGenres;
  final List<String> bookGenres;
  final List<String> platforms;

  const FormRequestModel({
    required this.movieGenres,
    required this.bookGenres,
    required this.platforms,
  });

  static List<int> filmGenresToCode(final List<String> filmGenres)
  {
    final List<int?> tempFilmCode =
        filmGenres.map((genre) => MovieGenre[genre]).toList();
    List<int> filmCodes = [];

    for (int i = 0; i < tempFilmCode.length; i++) {
      if (tempFilmCode[i] != null) {
        filmCodes.add(tempFilmCode[i] ?? 0);
      }
    }
    return filmCodes;
  }

  static FormRequestModel fillFormRequest(
      {required final Map<String, bool> filmGenres,
      required final Map<String, bool> literaryGenres,
      required final Map<String, bool> viewingPlatform})
  {
    final List<int> chosenMovieGenres = filmGenresToCode(
        filmGenres.entries.where((entry) => (entry.value == true))
            .map((entry) => entry.key)
            .toList());
    final List<String> chosenBookGenres = literaryGenres.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<String> chosenPlatforms = viewingPlatform.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    return FormRequestModel(
      movieGenres: chosenMovieGenres,
      bookGenres: chosenBookGenres,
      platforms: chosenPlatforms,
    );
  }
}

class FormResponseModel {
  final int statusCode;
  bool get isSuccessful =>
      statusCode == HttpStatus.OK || statusCode == HttpStatus.CREATED;

  const FormResponseModel({required this.statusCode});
}
