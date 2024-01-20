/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'saved_books_bloc.dart';

class SavedBooksState extends Equatable {
  const SavedBooksState({
    this.status = Status.initial,
    List<BookPreview>? savedBooks,
  }) : savedBooks = savedBooks ?? const [];

  final List<BookPreview> savedBooks;
  final Status status;

  @override
  List<Object?> get props => [status, savedBooks];

  SavedBooksState copyWith({
    List<BookPreview>? savedBooks,
    Status? status,
  }) {
    return SavedBooksState(
      savedBooks: savedBooks ?? this.savedBooks,
      status: status ?? this.status,
    );
  }
}
