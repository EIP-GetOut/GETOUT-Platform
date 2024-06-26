/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_services.dart';

class FormRequestModel {
  final List<int> movieGenres;
  final List<String> bookGenres;
  final List<String> viewingPlatform;

  const FormRequestModel({
    required this.movieGenres,
    required this.bookGenres,
    required this.viewingPlatform,
  });

  static List<int> movieGenresToCode(final List<String> selectedMovieGenres)
  {
    final List<int?> tempMovieCode =
    selectedMovieGenres.map((genre) => MovieGenreList[genre]).toList();
    List<int> movieCodes = [];

    for (int i = 0; i < tempMovieCode.length; i++) {
      if (tempMovieCode[i] != null) {
        movieCodes.add(tempMovieCode[i] ?? 0);
      }
    }
    return movieCodes;
  }

  static FormRequestModel fillFormRequest(
      {required final Map<String, bool> movieGenres,
      required final Map<String, bool> bookGenres,
      required final Map<String, bool> viewingPlatform})
  {
    final List<String> chosenBookGenres = bookGenres.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<String> chosenViewingPlatform = viewingPlatform.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<String> chosenMovieGenres = movieGenres.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<int> movieCodes = movieGenresToCode(chosenMovieGenres);

    return FormRequestModel(
      movieGenres: movieCodes,
      bookGenres: chosenBookGenres,
      viewingPlatform: chosenViewingPlatform,
    );
  }
}

class FormResponseModel {
  final int statusCode;
  bool get isSuccessful =>
      statusCode == HttpStatus.OK || statusCode == HttpStatus.CREATED;

  const FormResponseModel({required this.statusCode});
}
