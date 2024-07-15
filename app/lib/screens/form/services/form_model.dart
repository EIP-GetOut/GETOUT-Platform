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

  static List<int> movieGenresToCode(final List<String> filmGenres)
  {
    final List<int?> tempMovieCode =
        filmGenres.map((genre) => MovieGenre[genre]).toList();
    List<int> filmCodes = [];

    for (int i = 0; i < tempMovieCode.length; i++) {
      if (tempMovieCode[i] != null) {
        filmCodes.add(tempMovieCode[i] ?? 0);
      }
    }
    return filmCodes;
  }

  static List<String> bookGenresToCode(final List<String> bookGenres)
  {
    final List<String?> tempBookCode =
    bookGenres.map((genre) => BookGenre[genre]).toList();
    tempBookCode.removeWhere((element) => element == null);
    return List<String>.from(tempBookCode);
  }

  static FormRequestModel fillFormRequest(
      {required final Map<String, bool> movieGenres,
      required final Map<String, bool> bookGenres,
      required final Map<String, bool> platforms})
  {
    final List<int> chosenMovieGenres = movieGenresToCode(
        movieGenres.entries.where((entry) => entry.value == true)
            .map((entry) => entry.key)
            .toList());
    final List<String> chosenBookGenres = bookGenresToCode(
        bookGenres.entries.where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList());
    final List<String> chosenPlatforms = platforms.entries
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
