/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'book_bloc.dart';

class BookEvent extends Equatable {
  const BookEvent();
  @override
  List<Object?> get props => [];
}

class CreateInfoBookRequest extends BookEvent {
  final String id;
  const CreateInfoBookRequest({required this.id});
}

class InfoBookResponse extends BookEvent {
  const InfoBookResponse(
      {this.title,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.voteAverage,
      this.pageCount,
      this.genres,
      this.authorsPicture,
      this.liked, // Isn't send by the API
      this.disliked, // Isn't send by the API
      this.bookLink, // Isn't send by the API
      this.wishlisted, // Isn't send by the API
      this.read, // Isn't send by the API
      this.id,
      required this.statusCode});

  final PersonList? authorsPicture;
  static const int success = HttpStatus.OK;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final List<dynamic>? genres;
  final int? voteAverage;
  final int? pageCount;
  final bool? liked;
  final bool? disliked;
  final String? bookLink;
  final bool? wishlisted;
  final bool? read;
  final String? id;
  final int statusCode;
}


class AddBookRequest extends BookEvent {
  const AddBookRequest (
    {required this.id}
  );

  final String id;
}

class AddBookResponse extends BookEvent {
  const AddBookResponse (
    {required this.statusCode}
  );

  final int statusCode;

  static const int success = HttpStatus.CREATED;
}

class Person extends BookEvent {
  const Person (
    {required this.name,
    required this.picture}
  );

  final String name;
  final String picture;
}


typedef PersonList = List<Person>;
