/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'wishlist_books_bloc.dart';

enum WishlistBookStatus { initial, success, error, loading }

extension WishlistBookStatusX on WishlistBookStatus {
  bool get isInitial => this == WishlistBookStatus.initial;
  bool get isSuccess => this == WishlistBookStatus.success;
  bool get isError => this == WishlistBookStatus.error;
  bool get isLoading => this == WishlistBookStatus.loading;
}

class WishlistBooksState extends Equatable {
  const WishlistBooksState({
    this.status = WishlistBookStatus.initial,
    List<WishlistBookPreview>? books,
  }) : books = books ?? const [];

  final List<WishlistBookPreview> books;
  final WishlistBookStatus status;

  @override
  List<Object?> get props => [status, books];

  WishlistBooksState copyWith({List<WishlistBookPreview>? books, WishlistBookStatus? status}) {
    return WishlistBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
    );
  }
}
