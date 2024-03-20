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
      this.authorsPicture,
      this.liked,
      this.disliked,
      this.id,
      required this.statusCode});

  final List<Map<String, String?>>? authorsPicture;
  static const int success = HttpStatus.OK;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? pageCount;
  final bool? liked;
  final bool? disliked;
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

  static const int success = HttpStatus.OK;
}