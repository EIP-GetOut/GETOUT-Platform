/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';

class BooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const BooksEvent();
}

class GenerateBooksRequest extends BooksEvent {
  const GenerateBooksRequest();
}

class BookStatusResponse extends BooksEvent {
  const BookStatusResponse(
      {this.id,
        this.title,
        this.posterPath,
        this.overview,
        required this.statusCode});

  bool get isSuccess => statusCode == HttpStatus.OK;

  final String? id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int statusCode;
  static const int success = HttpStatus.OK;
}

class BookPreview extends BooksEvent {
  const BookPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      this.releaseDate,
      this.averageRating,
      this.genres});
  final String id;
  final String title;
  final String? posterPath;
  final String? overview;
  final String? releaseDate;
  final dynamic averageRating;
  final List<dynamic>? genres;

}

typedef GenerateBooksResponse = List<BookPreview>;
