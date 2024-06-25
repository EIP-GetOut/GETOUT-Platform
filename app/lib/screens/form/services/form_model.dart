/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_services.dart';

class FormRequestModel {
  final List<int> filmGenres;
  final List<String> literaryGenres;
  final List<String> viewingPlatform;

  const FormRequestModel({
    required this.filmGenres,
    required this.literaryGenres,
    required this.viewingPlatform,
  });

  static List<int> filmGenresToCode(final List<String> selectedFilmGenres)
  {
    final List<int?> tempFilmCode =
    selectedFilmGenres.map((genre) => FilmGenreList[genre]).toList();
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
    final List<String> chosenLiteraryGenres = literaryGenres.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<String> chosenViewingPlatform = viewingPlatform.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<String> chosenFilmGenres = filmGenres.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    final List<int> filmCodes = filmGenresToCode(chosenFilmGenres);

    return FormRequestModel(
      filmGenres: filmCodes,
      literaryGenres: chosenLiteraryGenres,
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
