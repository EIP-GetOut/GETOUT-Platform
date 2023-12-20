/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'book_bloc.dart';

class BookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateInfoBookRequest extends BookEvent {
  CreateInfoBookRequest({required this.id});

  final String id;
}

//ignore: must_be_immutable
class InfoBookResponse extends BookEvent {
  InfoBookResponse(
      {this.title,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.voteAverage,
      this.duration,
      this.authorsPicture,
      required this.statusCode});

  final List<Map<String, String?>>? authorsPicture;
  static const int success = HttpStatus.OK;
  final String? title;
  String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  String? duration;
  final int statusCode;
}
