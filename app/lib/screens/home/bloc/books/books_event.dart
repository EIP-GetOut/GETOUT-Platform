/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'books_bloc.dart';

class BooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateBooksRequest extends BooksEvent {
  GenerateBooksRequest({
    required this.genres,
    this.includeAdult = false,
  });
  final List<int> genres;
  final bool includeAdult;
}

class BookPreview extends BooksEvent {
  BookPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final String id;
  final String title;
  final String? posterPath;
  final String? overview;
}

typedef GenerateBooksResponse = List<BookPreview>;
