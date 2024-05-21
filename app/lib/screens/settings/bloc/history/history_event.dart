/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'history_bloc.dart';

class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const HistoryEvent();
}

class HistoryRequest extends HistoryEvent {
  const HistoryRequest();
}

//Book
class BookHistoryStatusResponse extends HistoryEvent {
  const BookHistoryStatusResponse(
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

class BookPreview extends HistoryEvent {
  const BookPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final String id;
  final String title;
  final String? posterPath;
  final String? overview;
}

//Movie
class MovieHistoryStatusResponse extends HistoryEvent {
  const MovieHistoryStatusResponse(
      {this.id,
        this.title,
        this.posterPath,
        this.overview,
        required this.statusCode});

  bool get isSuccess => statusCode == HttpStatus.OK;

  final int? id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int statusCode;
  static const int success = HttpStatus.OK;
}

class MoviePreview extends HistoryEvent {
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

//typedef
typedef HistoryMoviesResponse = List<MoviePreview>;
typedef HistoryBooksResponse = List<BookPreview>;
