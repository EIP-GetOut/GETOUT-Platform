/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'like_books_bloc.dart';

class LikeBooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLikeBooksRequest extends LikeBooksEvent {
  GetLikeBooksRequest();
}

class LikeBookPreview extends LikeBooksEvent {
  LikeBookPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final String id;
  final String title;
  final String? posterPath;
  final String? overview;
}

typedef GetLikeBooksResponse = List<LikeBookPreview>;
