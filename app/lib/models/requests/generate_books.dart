/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:getout/constants/http_status.dart';

class GenerateBooksRequest {
  List<int> genres;
  bool includeAdult = true;

  GenerateBooksRequest({
    required this.genres,
    this.includeAdult = false,
  });
}

class BookPreview {
  static const int success = HttpStatus.OK;
  String id;
  String title;
  String? posterPath;
  // String overview;
  //  required this.overview
  BookPreview(
      {required this.id, required this.title, required this.posterPath}); // required this.overview});
}

typedef GenerateBooksResponse = List<BookPreview>;
